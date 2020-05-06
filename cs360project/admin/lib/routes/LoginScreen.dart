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

  var url = 'http://mr-fluffy-fluffs.herokuapp.com/api/admin/login' ;
  // This function sends user login request to the API
  Future <dynamic> admin_login() async {
    var response = await Requests.post(
        url,
        body: body,
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
      ),

      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,

          child: Column(
            children: <Widget>[

              Container(
                child: Align(
                  child: Text(
                      "Admin",
                      style: TextStyle(
                          fontSize: blockWidth * 15, color: Color(0xffbb5e1e),fontFamily: 'NunitoSansSemiBold')
                  ),
                ),
              ),

            // SizedBox(height: blockWidth * 3),

             Container(
                // width: blockWidth * 100,
                height: blockWidth * 35,
                child: Stack(
                  children: <Widget>[
                  // alignment: Alignment.topCenter,
                  Icon(
                    Icons.person_outline,
                    size: blockWidth * 42,
                    color: Color(0xffbb5e1e),
                  ),
                  Icon(
                    Icons.settings,
                    size: blockWidth * 19,
                    color: Colors.black54,
                  ),
                  ],
                ),
              ),

              SizedBox(height: blockWidth * 10),

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
                    alignment: Alignment(-blockWidth * 0.26, 0), // -0.150
                    child: profile(blockWidth)
                  ),
                ],
              ),

              SizedBox(height: blockWidth * 4),

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
                    alignment: Alignment(-blockWidth * 0.26, 0),
                    child: padlock(blockWidth),
                  ),
                ],
              ),

              SizedBox(height: blockWidth * 4),

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
                          body = { "admin":{"Email":username, "PassHash":password} } ;
                        }

                        else {
                          body = { "admin":{"Username":username, "PassHash":password} } ;
                        }

                        resp = await Future.delayed(
                            const Duration(milliseconds: 3000), () => admin_login()) ;
                      }

                      // After [onPressed], it will trigger animation running backwards, from end to beginning
                      return () {
                        // Following are just the conditions (responses) from api according which user would either log in
                        // or displayed with some alert prompt message

                        if (resp['status'] == 'True') {
                          Navigator.of(context).pushReplacementNamed('/home_screen') ;
                        }

                        else if (resp['status'] == 'False') {
                          msg = display_result(resp['msg']) ;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return msg ;
                            },
                          ) ;
                        }

                        else {
                          // Do nothing as form data has not been validated
                        }

                      };
                    },
                  ),
                ),
              ),

              SizedBox(height: blockWidth * 0.5),

              Align(
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/forgotpassword') ;
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: blockWidth * 4,
                      fontFamily: 'NunitoSansLight',
                      color: Colors.black,
                    ),
                  ),

                ),
              ),

              SizedBox(height: blockWidth * 0.5),

            ],
          ),
        ),
      ),
    );
  }
}

