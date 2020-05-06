import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'dart:collection';
import 'package:flutter_progress_button/flutter_progress_button.dart' ;
import 'dart:collection';
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;

class SignupScreen3 extends StatefulWidget {
  @override
  _SignupScreen3State createState() => _SignupScreen3State();
}

class _SignupScreen3State extends State<SignupScreen3> {

  double screenWidth;
  double screenHeight;
  double blockSizeHorizontal;
  double blockSizeVertical;

  Map data = {} ;
  String username ;
  String password ;
  var body ;

  void init() {
    screenWidth = MediaQuery.of(context).size.width ;
    screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight ;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

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

  AlertDialog display_result(String message) {
    AlertDialog alert = AlertDialog (
      content: Text(message),
    ) ;

    return alert ;
  }

  @override
  Widget build(BuildContext context) {
    init() ;

    data = ModalRoute.of(context).settings.arguments ;
    username = data['username'] ;
    password = data['password'] ;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),

      body: Column(
        children: <Widget>[
          Container(
              height: blockSizeVertical * 50,
              width: blockSizeHorizontal * 100,
              color: Colors.white,
              child: Image.asset(
                  'assets/signupthree.png'
              )
          ),

          Container(
            height: blockSizeVertical * 50,
            width: blockSizeHorizontal * 100,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'All done',
                  style: TextStyle(
                    fontSize: blockSizeHorizontal * 6,
                    fontFamily: 'NunitoSansSemiBold',
                    color: Color(0xffbb5e1e),
                  ),
                ),

                SizedBox(height: blockSizeHorizontal * 15) ,

                ProgressButton(
                  animate: true,
                  color: Color(0xffbb5e1e),
                  defaultWidget: Text(
                    'Proceed',
                    style: TextStyle(
                      fontSize: blockSizeHorizontal * 5,
                      fontFamily: 'NunitoSansSemiBold',
                      color: Colors.white,
                    ),
                  ),
                  progressWidget: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  width: blockSizeHorizontal * 40,
                  height: blockSizeHorizontal * 19,
                  borderRadius: blockSizeHorizontal * 10,
                  onPressed: () async {
                    dynamic resp ;
                    AlertDialog msg ;

                    body = { "customer":{"Username":username, "PassHash":password} } ;

                    resp = await Future.delayed(
                        const Duration(milliseconds: 3000), () => user_login()) ;

                    // After [onPressed], it will trigger animation running backwards, from end to beginning
                    return () {
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

              ],
            ),
          ),

        ],
      ),
    );
  }
}
