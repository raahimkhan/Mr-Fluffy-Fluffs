import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter_progress_button/flutter_progress_button.dart' ;
import 'package:validators/validators.dart' ;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'dart:collection';
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // Screen details
  double height ;
  double width ;
  double blockWidth;
  double blockHeight;

  String username = "" ;
  String password = "" ;

  screenDetails(){
    // Height minus the notifications and the tool bar and the bottom bar (which usually contains back and home buttons)
    // This will give the true available height
    height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight ;
    width = MediaQuery.of(context).size.width ;
    blockWidth = width / 100;
    blockHeight = height / 100;
  }

  // Widget that displays lock icon inside a circle
  Widget padlock(blockWidth) {
    return Container(
    height: blockWidth * 20,
    width: blockWidth * 20,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/padlock.png'),
        )
    ),
  ) ;
}

  // Widget that displays profile icon inside a circle
  Widget profile (blockWidth) {
    return Container(
    height: blockWidth * 20,
    width: blockWidth * 20,
    decoration: BoxDecoration (
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage('assets/loginprofile.jfif'),
        )
      ),
    );
  }

  // this is to store the form state globally so form data could be uniquely recognized
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>() ;

  // hand made function to display alert boxes to users
  AlertDialog display_result(String message) {
    AlertDialog alert = AlertDialog (
      content: Text(message),
    ) ;

    return alert ;
  }

  var body ; // to store username and password as a json object to send to API for logging in

  var url = 'http://mr-fluffy-fluffs.herokuapp.com/api/user/login' ;
  // This function sends user login request to the API
  Future <dynamic> user_login() async {
    var response = await Requests.post(
        url,
        body: body,
        timeoutSeconds: 25,
        bodyEncoding: RequestBodyEncoding.JSON
    ) ;

    dynamic j = response.json() ;
    return j ;
  }

  @override
  Widget build(BuildContext context) {
    screenDetails() ;
    return Scaffold(
      resizeToAvoidBottomPadding: false,  // prevents overflow (resize the widgets)
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector( // widget that detects user gestures
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/opening_screen') ;
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            size: blockWidth * 13,
            color: Color(0xffbb5e1e),
          ),
        ),
      ),

      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,

          child: Column(
            children: <Widget>[

              Container(
                width: blockWidth * 100,
                height: blockWidth * 48,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/login.png', 
                    fit: BoxFit.contain
                  ),
                ),
              ),

              SizedBox(height: blockWidth * 3),
              
              Stack(
                children: <Widget>[
                  Container(
                    width: blockWidth * 100,
                    child: Align(
                      child: SizedBox(
                        width: blockWidth * 86,
                        height: blockWidth * 20,

                        child: TextFormField(
                          autofocus: true,
                          onChanged: (String user){
                            setState(() {
                              username = user ;
                            });
                          },
                          textAlign: TextAlign.left,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Username can't be empty" ;
                            }
                            return null ;
                          },

                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(blockWidth * 10),
                              ),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: blockWidth * 6.5,
                              fontFamily: 'NunitoSansLight',
                            ),
                            hintText: "Username",
                            contentPadding: EdgeInsets.fromLTRB(blockWidth * 28, blockWidth * 10, 0.0, 0.0),
                            fillColor: Color(0x73ff8000),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-blockWidth * 0.20, 0), // -0.150
                    child: profile(blockWidth)
                  ),
                ],
              ),

              SizedBox(height: blockWidth * 2),

              Stack(
                children: <Widget>[
                  Container(
                    width: blockWidth * 100,
                    child: Align(
                      child: SizedBox(
                        width: blockWidth * 86,
                        height: blockWidth * 20,
                        child: TextFormField(
                          obscureText: true,
                          autofocus: true,
                          onChanged: (String pass){
                            setState(() {
                              password = pass ;
                            });
                          },
                          textAlign: TextAlign.left,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Password can't be empty" ;
                            }
                            return null ;
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(blockWidth * 10),
                              ),
                              borderSide: BorderSide(color: Colors.white, width: 0.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: blockWidth * 6.5,
                              fontFamily: 'NunitoSansLight',
                            ),
                            hintText: "Password",
                            contentPadding: EdgeInsets.fromLTRB(blockWidth * 28, blockWidth * 10, 0.0, 0.0),
                            fillColor: Color(0x73ff8000),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-blockWidth * 0.20, 0),
                    child: padlock(blockWidth),
                  ),
                ],
              ),

              SizedBox(height: blockWidth * 2),

              Container(
                width: blockWidth * 80,
                child: Align(
                  child: ProgressButton(
                    animate: true,
                    color: Color(0xffbb5e1e),
                    defaultWidget: Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: blockWidth * 6.5,
                        fontFamily: 'NunitoSansSemiBold',
                      ),
                    ),
                    progressWidget: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    width: blockWidth * 65,
                    height: blockWidth * 14,
                    borderRadius: blockWidth * 10,
                    onPressed: () async {
                      dynamic resp ;
                      AlertDialog msg ;
                      if (_formKey.currentState.validate()) {

                        // json object will be sent according to whether user entered email or username

                        if (username.contains('@')) {
                          body = { "customer":{"Email":username, "PassHash":password} } ;
                        }

                        else {
                          body = { "customer":{"Username":username, "PassHash":password} } ;
                        }

                        resp = await Future.delayed(
                            const Duration(milliseconds: 3000), () => user_login()) ;
                      }

                      // After [onPressed], it will trigger animation running backwards, from end to beginning
                      return () {
                        // Following are just the conditions (responses) from api according which user would either log in
                        // or displayed with some alert prompt message

                        if (resp['status'] == 'False' && resp['msg'].contains('already logged in')) {
                          Navigator.of(context).pushReplacementNamed('/home_screen') ;
                        }

                        else if (resp['status'] == 'False' && !resp['msg'].contains('already logged in')) {
                          msg = display_result(resp['msg']) ;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return msg ;
                            },
                          ) ;
                        }

                        else if (resp['status'] == 'True') {
                          Navigator.of(context).pushReplacementNamed('/home_screen') ;
                        }

                        else {
                          // Do nothing as form data has not been validated
                        }

                      };
                    },
                  ),
                ),
              ),

              SizedBox(height: blockWidth * 3.5),

              // // Yet to be implemented
              Align(
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/forgotpassword') ;
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: blockWidth * 5,
                      fontFamily: 'NunitoSansLight',
                      color: Colors.black,
                    ),
                  ),

                ),
              ),

              SizedBox(height: blockWidth * 1.5),

              Align(
                child: Text(
                  "Don't have an account yet?",
                  style: TextStyle(
                    fontSize: blockWidth * 4.5,
                    fontFamily: 'NunitoSansLight',
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: blockWidth * 1.5),

              Align(
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/signup_screen1') ;
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: blockWidth * 5,
                      fontFamily: 'NunitoSansLight',
                      color: Color(0xffbb5e1e),
                    ),
                  ),

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

