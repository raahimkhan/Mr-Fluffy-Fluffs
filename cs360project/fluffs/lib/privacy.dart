import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:collection';
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;
import 'package:validators/validators.dart' ;

AlertDialog display_result(String message) {
  AlertDialog alert = AlertDialog (
    content: Text(message),
  ) ;

  return alert ;
}

var status_url = 'http://mr-fluffy-fluffs.herokuapp.com/api/user/' ;

// These are the current credentials
String username ;
String fname ;
String email ;
String address ;
String phone ;

// These are the updated credentials if user decides to updated any. Initially all are "Nil"
String new_username = "Nil" ;
String new_fname = "Nil"  ;
String new_email = "Nil"  ;
String new_address = "Nil"  ;
String new_phone  = "Nil" ;

// to check whether guest is logged in or a registered user
Future <dynamic> check_status() async {
  var response = await Requests.get(
    status_url,
  );
  response.raiseForStatus();

  dynamic user_data = response.json() ;

  if (user_data['msg'].contains('You must be logged in to access this feature')) {  // guest is logged in
    // Nil because guest has no details stored
    username = 'Nil' ;
    fname = 'Nil' ;
    email = 'Nil' ;
    address = 'Nil' ;
    phone = 'Nil' ;
  }

  else { // user is logged in
    dynamic data = user_data['data'] ;

    username = data['Username'] ;
    fname = data['FullName'] ;
    email = data['Email'] ;
    address = data['Address'] ;
    phone = data['MobileNo'] ;

    // Here I am just converting number from format +923084352787 to 03084352787
    phone = phone.substring(3);
    phone = "0" + phone ;
  }

  return user_data ;
}

var body ;

var patch_url = 'http://mr-fluffy-fluffs.herokuapp.com/api/user/' ;

Future <void> change_details() async {
  var response = await Requests.patch(
      patch_url,
      body: body,
      bodyEncoding: RequestBodyEncoding.JSON
  ) ;

  dynamic j = response.json() ;
}

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;

    return new Material(
        child: new FutureBuilder <dynamic> (
          future: check_status(), // this future builder will determine whether guest is logged in or a registered user
            builder: (BuildContext context, AsyncSnapshot <dynamic> feedState) {
              if (feedState.hasData) {
                // This means future has been completed and we can use the data received to build our widgets
              }

              else {
                // This will run until future has not been completed
                return new Center(child: new CircularProgressIndicator()) ;
              }

              return  Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: blockHeight * 2.8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.keyboard_arrow_left),
                          color: Colors.red[400],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        lines(blockWidth),

                        section("Username", username),

                        text_field(blockWidth, 'new_username', new_username),

                        section("Full Name", fname),

                        text_field(blockWidth, 'new_fname', new_fname),

                        section("Email", email),

                        text_field(blockWidth, 'new_email', new_email),

                        section("Address", address),

                        text_field(blockWidth, 'new_address', new_address),

                        section("Phone Number", phone),

                        text_field(blockWidth, 'new_phone', new_phone),

                        SizedBox(height: 40,),

                        Center(
                          child: SizedBox(
                            width: blockWidth * 40,
                            height: blockHeight * 6,
                            child: RaisedButton(
                              onPressed: () {

                                Navigator.pop(context);

                                Navigator.push(
                                  context,MaterialPageRoute(
                                  builder: (context) => Privacy(),
                                ),
                                );

                              },
                              textColor: Colors.white,
                              color: Color(0xffbb5e1e),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: blockWidth * 4,
                                  fontFamily: 'NunitoSans-SemiBold',
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(blockWidth * 6)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
        ),

    );
  }
}

Widget section(p1, p2) {
  return Builder(
    builder: (BuildContext context) {
      var wTH = MediaQuery.of(context).size.width;
      var blockWidth = wTH / 100;
      var hTH = MediaQuery.of(context).size.height;
      var blockHeight = hTH / 100;
      return ListTile(
        title: Text(
          p1,
          style: TextStyle(
            fontSize: blockWidth * 4,
            fontWeight: FontWeight.bold,
            color: Colors.brown[400],
          ),
        ),
        subtitle: Text(
          "$p2",
            style: TextStyle(
            fontSize: blockWidth * 3,
            color: Colors.brown[200],
          ),
        ),
        trailing: IconButton(
          onPressed: (){
            if (p1 == "Username") {
              if (new_username != "Nil") {
                body = { "customer": { "Username": new_username}};
                change_details();
              }
            }

            else if (p1 == "Full Name") {
            if (new_fname != "Nil") {
              body = { "customer": { "FullName": new_fname}};
              change_details();
            }
            }

            else if (p1 == "Email") {
              if (new_email != "Nil") {
                body = { "customer": { "Email": new_email}};
                change_details();
              }
            }

            else if (p1 == "Address") {
              if (new_address != "Nil") {
                body = { "customer": { "Address": new_address}};
                change_details();
              }
            }

            else if (p1 == "Phone Number") {
              if (new_phone != "Nil") {
                new_phone = new_phone.substring(1) ;
                new_phone = '+92' + new_phone ;
                body = { "customer": { "MobileNo": new_phone}};
                change_details();
              }
            }
          },
          icon: Icon(Icons.edit),
          color: Colors.red,
        ),
      );
    }
  );
}


Widget text_field(wTH, info, variable) {
  return Container(
    width: wTH * 6,
    child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            variable = "Nil" ;
          }

          if (info == 'new_phone') {
            if (value.length < 11) {
              return "Phone number can't be less than 11 digits" ;
            }

            if (isAlpha(value)) {
              return "Phone number can't contain letters" ;
            }
          }

          else if (info == 'new_email') {
            if(!isEmail(value)) {
              return "Enter a valid email address" ;
            }
          }

          return null ;
        },
      autofocus: true,
      onChanged: (String detail){
          if (info == "new_username") {
            new_username = detail ;
          }

          else if (info == "new_fname") {
            new_fname = detail ;
          }

          else if (info == "new_email") {
            new_email = detail ;
          }

          else if (info == "new_address") {
            new_address = detail ;
          }

          else if (info == "new_phone") {
            new_phone = detail ;
          }
      },
    ),
  ) ;
}

Widget lines(wTH) {
  return Divider(
    thickness: 0.4,
    color: Colors.black,
    indent: wTH * 1,
    endIndent: wTH * 1,
  );
}

