import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' ;
import 'package:flutter_progress_button/flutter_progress_button.dart' ;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'dart:collection';

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
  int number ;
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

  Future <String> register() async {
    Map<String, String> headers = new HashMap() ;
    headers['Accept'] = 'application/json' ;
    headers['Content-type'] = 'application/json' ;

    http.Response response = await http.put(
        'http://mr-fluffy-fluffs.herokuapp.com/api/user/',
      headers: headers,
      body: jsonEncode(body),
      encoding: Encoding.getByName('utf-8')
    ) ;

    Map data = jsonDecode(response.body) ;

    print(data) ;

    return data['msg'] ;
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
            size: 45,
            color: Color(0xffbb5e1e),
          ),
        ),
      ),

      body: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: blockSizeVertical * 26,
                  //width: blockSizeHorizontal * 74,
                  color: Colors.white,
                  child: Image.asset('assets/signupone.png', scale: 0.8),
                ),

                Container(
                  height: blockSizeVertical * 76, // 62
                  width: blockSizeHorizontal * 100,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Container(
                        width: 320,
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
                              fontSize: 19,
                              fontFamily: 'NunitoSansLight',
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 13) ,

                      Container(
                        width: 320,
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
                              fontSize: 19,
                              fontFamily: 'NunitoSansLight',
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 13) ,

                      Container(
                        width: 320,
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
                              fontSize: 19,
                              fontFamily: 'NunitoSansLight',
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 13) ,

                      Container(
                        width: 320,
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
                              number = int.parse(pn) ;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Phone number",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontFamily: 'NunitoSansLight',
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 13) ,

                      Container(
                        width: 320,
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
                              fontSize: 19,
                              fontFamily: 'NunitoSansLight',
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 13) ,

                      Container(
                        width: 320,
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
                              fontSize: 19,
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

            Align(
              alignment: Alignment(0.876, 0.941), // 0.88, 0.4
              child: ProgressButton(
                animate: true,
                color: Color(0xffbb5e1e),
                defaultWidget: const Icon(
                  Icons.keyboard_arrow_right,
                  size: 67,
                  color: Colors.white,
                ),
                progressWidget: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                width: 60,
                height: 60,
                borderRadius: 30.0,
                onPressed: () async {
                  String resp ;
                  AlertDialog msg ;
                  if (_formKey.currentState.validate()) {
                      body = { "customer":{ "FullName":fullname, "Username":username, "PassHash":password, "Address":"Null", "Email":email,
                        "MobileNo":number } } ;

                    resp = await Future.delayed(
                        const Duration(milliseconds: 4000), () => register()) ;
                  }

                  // After [onPressed], it will trigger animation running backwards, from end to beginning
                  return () {

                    print(resp) ;

                    if (resp == 'Customer added and logged in. Verification Required for further access.') {
                      Navigator.of(context).pushReplacementNamed('/signup_screen2',
                      arguments: {
                        'type': username,
                        'name': fullname,
                        'pass': password,
                      }) ;
                    }

                    else if (resp == 'Email already present.') {
                      msg = display_result('This email is taken. Please use another one.') ;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return msg ;
                        },
                      ) ;
                    }

                    else if (resp == 'Username already present.') {
                      msg = display_result('This username is taken. Please choose another one.') ;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return msg ;
                        },
                      ) ;
                    }

                    else if (resp == 'Error hashing user password.') {
                      msg = display_result('Application is unavailable. Please try again later.') ;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return msg ;
                        },
                      ) ;
                    }

                    else if (resp == 'Internal Server Error.') {
                      msg = display_result('Service Unavailable. Please try again later.') ;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return msg ;
                        },
                      ) ;
                    }

                    else {
                      // Do nothing as form data has not been validated.
                    }
                  };
                },
              ),
            )

          ],
        ),
      ),
    ) ;
  }
}

