import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'dart:collection';
import 'package:flutter_progress_button/flutter_progress_button.dart' ;

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
  String fullname ;
  var body ;

  void init() {
    screenWidth = MediaQuery.of(context).size.width ;
    screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight ;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  Future <String> user_login() async {
    Map<String, String> headers = new HashMap() ;
    headers['Accept'] = 'application/json' ;
    headers['Content-type'] = 'application/json' ;

    http.Response response = await http.post(
        'http://mr-fluffy-fluffs.herokuapp.com/api/user/login',
        headers: headers,
        body: jsonEncode(body),
        encoding: Encoding.getByName('utf-8')
    ) ;

    Map data = jsonDecode(response.body) ;
    return data['msg'] ;
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
    username = data['type'] ;
    password = data['pass'] ;
    fullname = data['name'] ;

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
                    fontSize: 38,
                    fontFamily: 'NunitoSansSemiBold',
                    color: Color(0xffbb5e1e),
                  ),
                ),

                SizedBox(height: 133) ,

                ProgressButton(
                  animate: true,
                  color: Color(0xffbb5e1e),
                  defaultWidget: const Text(
                    'Proceed',
                    style: TextStyle(
                      fontSize: 23.0,
                      fontFamily: 'NunitoSansSemiBold',
                      color: Colors.white,
                    ),
                  ),
                  progressWidget: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  width: 260,
                  height: 54,
                  borderRadius: 30.0,
                  onPressed: () async {
                    String resp ;
                    AlertDialog msg ;

                    body = { "customer":{"Username":username, "PassHash":password} } ;

                    resp = await Future.delayed(
                        const Duration(milliseconds: 3000), () => user_login()) ;

                    // After [onPressed], it will trigger animation running backwards, from end to beginning
                    return () {
                      if (resp == 'Customer Already logged in.') {
                        msg = display_result('Already logged in.') ;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return msg ;
                          },
                        ) ;
                      }

                      else if (resp == 'Credentials has been changed. Please log in agains.') {
                        msg = display_result('Credentials has been changed. Please log in agains.') ;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return msg ;
                          },
                        ) ;
                      }

                      else if (resp == '') {
                        // do nothing as form data not validated
                      }

                      else if (resp == 'Invalid Username or Password.') {
                        msg = display_result('Invalid Username or Password.') ;
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
                        Navigator.of(context).pushReplacementNamed('/home_screen') ;
//                            arguments: {
//                              'type': fullname,
//                            }) ;
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
