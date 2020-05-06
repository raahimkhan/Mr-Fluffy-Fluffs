import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' ;
import 'package:flutter_progress_button/flutter_progress_button.dart' ;
import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;

class SignupScreen1 extends StatefulWidget {
  @override
  _SignupScreen1State createState() => _SignupScreen1State();
}

class _SignupScreen1State extends State<SignupScreen1> {

  double screenWidth;
  double screenHeight;
  double blockSizeHorizontal;
  double blockSizeVertical;

  // screen details
  void init() {
    screenWidth = MediaQuery.of(context).size.width ;
    screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight ;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  String username ;
  String fullname  ;
  String email ;
  String number ;
  String address ;
  String password ;
  String password2 ; // same as password just another variable to match password entered in 'confirm password' field
  var body ; // to store json object for sending to API

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>() ;

  AlertDialog display_result(String message) {
    AlertDialog alert = AlertDialog (
      content: Text(message),
    ) ;

    return alert ;
  }

  var url = 'http://mr-fluffy-fluffs.herokuapp.com/api/user/' ;

  Future <dynamic> register() async {
    var response = await Requests.put(
        url,
        body: body,
        bodyEncoding: RequestBodyEncoding.JSON
    ) ;

    dynamic j = response.json() ;
    return j ;
  }

  @override
  Widget build(BuildContext context) {
    init() ;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/opening_screen') ;
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            size: blockSizeHorizontal * 10,
            color: Color(0xffbb5e1e),
          ),
        ),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          primary: false,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: blockSizeHorizontal * 25,
                    color: Colors.white,
                    child: Image.asset('assets/signupone.png',
                    fit: BoxFit.contain),
                  ),

                  Container(
                    width: blockSizeHorizontal * 80,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Container(
                          width: blockSizeHorizontal * 100,
                          child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Username can't be empty" ;
                              }

                              if (value.length < 3) {
                                return "Username can't be less than 3 charachters" ;
                              }

                              if (isInt(value)) {
                                return "Username can't contain integers only" ;
                              }

                              return null ;
                            },
                            autofocus: true,
                            onChanged: (String user){
                              setState(() {
                                username = user ;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Username",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: blockSizeHorizontal * 6,
                                fontFamily: 'NunitoSansLight',
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: blockSizeVertical * 2) ,

                        Container(
                          width: blockSizeHorizontal * 100,
                          child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Full name can't be empty" ;
                              }

                              if (value.length < 3) {
                                return "Full name can't be less than 3 charachters" ;
                              }

                              if (isInt(value)) {
                                return "Full name can't contain integers" ;
                              }

                              return null ;
                            },

                            autofocus: true,

                            onChanged: (String fn){
                              setState(() {
                                fullname = fn ;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Full name",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: blockSizeHorizontal * 6,
                                fontFamily: 'NunitoSansLight',
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: blockSizeVertical * 2) ,

                        Container(
                          width: blockSizeHorizontal * 100,
                          child: TextFormField(
                            validator: (String value) {

                              if (value.isEmpty) {
                                return "Email can't be empty" ;
                              }

                              if(!isEmail(value)) {
                                return "Enter a valid email address" ;
                              }

                              return null ;
                            },

                            autofocus: true,

                            onChanged: (String em){
                              setState(() {
                                email = em ;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: blockSizeHorizontal * 6,
                                fontFamily: 'NunitoSansLight',
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: blockSizeVertical * 2) ,

                        Container(
                          width: blockSizeHorizontal * 100,
                          child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Phone number can't be empty" ;
                              }

                              if (value.length < 11) {
                                return "Phone number can't be less than 11 digits" ;
                              }

                              if (isAlpha(value)) {
                                return "Phone number can't contain letters" ;
                              }

                              return null ;
                            } ,

                            autofocus: true,

                            onChanged: (String pn){
                              setState(() {
                                number = pn ;
                                number = number.substring(1) ;
                                number = '+92' + number ;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Phone number",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: blockSizeHorizontal * 6,
                                fontFamily: 'NunitoSansLight',
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: blockSizeVertical * 2) ,

                        Container(
                          width: blockSizeHorizontal * 100,
                          child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Address can't be empty" ;
                              }

                              return null ;
                            } ,

                            autofocus: true,

                            onChanged: (String adr){
                              setState(() {
                                address = adr ;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Address",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: blockSizeHorizontal * 6,
                                fontFamily: 'NunitoSansLight',
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: blockSizeVertical * 2) ,

                        Container(
                          width: blockSizeHorizontal * 100,
                          child: TextFormField(
                            obscureText: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Password can't be empty" ;
                              }

                              if (value.length < 8) {
                                return "Password can't be less than 8 charachters" ;
                              }
                              return null ;
                            },
                            autofocus: true,
                            onChanged: (String pw){
                              setState(() {
                                password = pw ;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: blockSizeHorizontal * 6,
                                fontFamily: 'NunitoSansLight',
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: blockSizeVertical * 2) ,

                        Container(
                          width: blockSizeHorizontal * 100,
                          child: TextFormField(
                            obscureText: true,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "This field can't be empty" ;
                              }

                              if (value.length < 8 || password2 != password) {
                                return "Passwords don't match" ;
                              }
                              return null ;
                            },
                            autofocus: true,
                            onChanged: (String pw2){
                              setState(() {
                                password2 = pw2 ;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: blockSizeHorizontal * 6,
                                fontFamily: 'NunitoSansLight',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: blockSizeHorizontal * 15,
        child: Align(
          alignment: Alignment(blockSizeHorizontal * 0.2, 0.0),
          child: ProgressButton(
            animate: true,
            color: Color(0xffbb5e1e),
            defaultWidget: Icon(
              Icons.keyboard_arrow_right,
              size: blockSizeHorizontal * 15,
              color: Colors.white,
            ),
            progressWidget: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            width: blockSizeHorizontal * 20,
            height: blockSizeHorizontal * 20,
            borderRadius: blockSizeHorizontal * 10,
            onPressed: () async {
              dynamic resp ;
              AlertDialog msg ;
              bool done = false ;
              if (_formKey.currentState.validate()) {
                done = true ;
                body = { "customer":{ "FullName":fullname, "Username":username, "PassHash":password, "Address":address, "Email":email,
                  "MobileNo":number } } ;

                resp = await Future.delayed(
                    const Duration(milliseconds: 5000), () => register()) ;
              }

              // After [onPressed], it will trigger animation running backwards, from end to beginning
              return () {
                if (done == true) {
                  if (resp['status'] == "False") {
                    msg = display_result(resp['msg']) ;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return msg ;
                      },
                    ) ;
                  }

                  else if (resp['status'] == "True") {
                    Navigator.of(context).pushReplacementNamed('/signup_screen2',
                        arguments: {
                          "code": resp['code'],
                          "number": number,
                          "username": username,
                          "password": password,
                        }) ;
                  }
                }

              };
            },
          ),
        ),
      ),
    ) ;
  }
}

