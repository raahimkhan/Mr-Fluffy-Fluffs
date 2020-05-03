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

  String username = "" ;
  String password = "" ;

  screenDetails(){
    // Height minus the notifications and the tool bar and the bottom bar (which usually contains back and home buttons)
    // This will give the true available height
    height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight ;
    width = MediaQuery.of(context).size.width ;
  }

  // Widget that displays lock icon inside a circle
  Widget padlock = Container(
    height: 65.0,
    width: 60.0,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/padlock.png'),
        )
    ),
  ) ;

  // Widget that displays profile icon inside a circle
  Widget profile = Container(
    height: 65.0,
    width: 60.0,
    decoration: BoxDecoration (
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage('assets/loginprofile.jfif'),
        )
    ),
  ) ;

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
            size: 45,
            color: Color(0xffbb5e1e),
          ),
        ),
      ),

      body: Form(
        key: _formKey,
        child: Container(
          height: height,
          width: width,
          color: Colors.white,

          child: Stack(
            children: <Widget>[

              Align(
                alignment: Alignment(0.0, -0.89),
                child: Image.asset('assets/login.png', scale: 2.4),
              ),

              SizedBox(height: 30),

              Align(
                alignment: Alignment(0.0, -0.20),

                child: SizedBox(
                  width: 340,
                  height: 66,

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
                          Radius.circular(1000.0),
                        ),
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'NunitoSansLight',
                      ),
                      hintText: "Username",
                      contentPadding: EdgeInsets.fromLTRB(80.0, 40.0, 0.0, 0.0),
                      fillColor: Color(0x73ff8000),
                    ),
                  ),
                ),
              ),

              Align(
                  alignment: Alignment(-0.757, -0.200), // -0.150
                  child: profile
              ),

              SizedBox(height: 40),

              Align(
                alignment: Alignment(0.0, 0.16),
                child: SizedBox(
                  width: 340,
                  height: 63,
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
                          Radius.circular(45.0),
                        ),
                        borderSide: BorderSide(color: Colors.white, width: 0.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'NunitoSansLight',
                      ),
                      hintText: "Password",
                      contentPadding: EdgeInsets.fromLTRB(80.0, 36, 0.0, 0.0),
                      fillColor: Color(0x73ff8000),
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment(-0.757, 0.16),
                child: padlock,
              ),

              SizedBox(height: 40),

              Align(
                alignment: Alignment(0.0, 0.47),
                child: ProgressButton(
                  animate: true,
                  color: Color(0xffbb5e1e),
                  defaultWidget: const Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23.0,
                      fontFamily: 'NunitoSansSemiBold',
                    ),
                  ),
                  progressWidget: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  width: 250,
                  height: 53,
                  borderRadius: 30.0,
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

              SizedBox(height: 40),

              // Yet to be implemented
              Align(
                alignment: Alignment(0.0, 0.65),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/forgotpassword') ;
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: 'NunitoSansLight',
                      color: Colors.black,
                    ),
                  ),

                ),
              ),

              SizedBox(height: 40),

              Align(
                alignment: Alignment(0.0, 0.79),
                child: Text(
                  "Don't have an account yet?",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'NunitoSansLight',
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: 40),

              Align(
                alignment: Alignment(0.0, 0.94),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/signup_screen1') ;
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 18,
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

