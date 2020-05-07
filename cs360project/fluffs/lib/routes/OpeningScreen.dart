import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;
import 'dart:async';
import 'dart:collection';
import 'package:flutter_progress_button/flutter_progress_button.dart' ;
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;

class OpeningScreen extends StatefulWidget {
  @override
  _OpeningScreenState createState() => new _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {

  AlertDialog display_result(String message) {
    AlertDialog alert = AlertDialog (
      content: Text(message),
    ) ;

    return alert ;
  }

  // Variables to store screen details
  double screenWidth;
  double screenHeight;
  // Variables to store how much screen certain widget will occupy based on screen details
  double blockSizeHorizontal;
  double blockSizeVertical;

  void init() {
    screenWidth = MediaQuery.of(context).size.width ;
    // Height minus the notifications and the tool bar and the bottom bar (which usually contains back and home buttons)
    // This will give the true available height
    screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight ;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  // API to login as a guest
  String url = 'http://mr-fluffy-fluffs.herokuapp.com/api/guest/login' ;

  // This function sends guest login request to the API
  Future <dynamic> guest_login() async {
    var response = await Requests.post(
        url,
        body: {},
        bodyEncoding: RequestBodyEncoding.JSON
    ) ;

    dynamic j = response.json() ;
    return j ;
  }

  @override
  Widget build(BuildContext context) {
    init() ;
    return Scaffold(
        resizeToAvoidBottomPadding: false, // prevents overflow (resize the widgets)
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            // Widget containing title and the logo
            Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.white,
                child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(height: blockSizeHorizontal * 15),

                      Text(
                          "Mr. Fluffy Fluffs",
                          style: TextStyle(
                              fontSize: blockSizeHorizontal * 10, color: Color(0xffbb5e1e),fontFamily: 'NunitoSansLight')
                      ),

                      SizedBox(
                        width: blockSizeHorizontal * 60,
                        height: blockSizeHorizontal * 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: blockSizeHorizontal * 60,
                              height: blockSizeHorizontal * 50,
                              child: Image.asset('assets/loading_screen.png', 
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                ),
              ),
            ),

            SizedBox(height: blockSizeHorizontal * 8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: ProgressButton(
                        animate: true,
                        color: Color(0xffbb5e1e),
                        defaultWidget: Text(
                          'Log in',
                          style: TextStyle(
                            fontSize: blockSizeHorizontal * 5,
                            fontFamily: 'NunitoSansSemiBold',
                            color: Colors.white,
                          ),
                        ),

                        // This is an animation widget which loads while the screen is traversed
                        progressWidget: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        width: blockSizeHorizontal * 75,
                        height: blockSizeHorizontal * 12.5,
                        borderRadius: blockSizeHorizontal * 10,
                        onPressed: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 2000), () => {}) ;
                          // After [onPressed], it will trigger animation running backwards, from end to beginning
                          return () {
                            Navigator.of(context).pushReplacementNamed('/login_screen') ;
                          };
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: blockSizeHorizontal * 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: ProgressButton(
                        animate: true,
                        color: Color(0xffbb5e1e),
                        defaultWidget: Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: blockSizeHorizontal * 5,
                            fontFamily: 'NunitoSansSemiBold',
                            color: Colors.white,
                          ),
                        ),
                        progressWidget: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        width: blockSizeHorizontal * 75,
                        height: blockSizeHorizontal * 12,
                        borderRadius: blockSizeHorizontal * 10,
                        onPressed: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 2000), () => {}) ;
                          // After [onPressed], it will trigger animation running backwards, from end to beginning
                          return () {
                            Navigator.of(context).pushReplacementNamed('/signup_screen2') ;
                          };

                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: blockSizeHorizontal * 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: ProgressButton(
                        animate: true,
                        color: Color(0xffbb5e1e),
                        defaultWidget: Text(
                          'Log in as a guest',
                          style: TextStyle(
                            fontSize: blockSizeHorizontal * 5,
                            fontFamily: 'NunitoSansSemiBold',
                            color: Colors.white,
                          ),
                        ),
                        progressWidget: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        width: blockSizeHorizontal * 75,
                        height: blockSizeHorizontal * 12.5,
                        borderRadius: blockSizeHorizontal * 10,
                        onPressed: () async {
                          dynamic resp ;
                          resp = await Future.delayed(
                              const Duration(milliseconds: 2000), () => guest_login()) ;
                          // After [onPressed], it will trigger animation running backwards, from end to beginning
                          return () {

                            if (resp['status'] == 'False' && resp['msg'].contains('already logged in') && !resp['msg'].contains('Cannot login as a guest now')) {
                              // If already logged in let guess bypass the opening screen to home page
                              Navigator.of(context).pushReplacementNamed('/home_screen') ;
                            }

                            else if (resp['status'] == 'True') {
                              Navigator.of(context).pushReplacementNamed('/home_screen') ;
                            }

                            else if (resp['status'] == 'False' && resp['msg'].contains('User already logged in. Cannot login as a guest now.')) {
                              AlertDialog msg = display_result(resp['msg']) ;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return msg ;
                                },
                              ) ;
                            }

                            else if (resp['status'] == "True") {
                              Navigator.of(context).pushReplacementNamed('/forgotpassword_screen1') ;
                            }

                          };
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: blockSizeHorizontal * 6),
                // This is a divider widget
                Stack(
                  children: <Widget>[
                    Divider(
                      color: Color(0xffbb5e1e),
                      thickness: blockSizeHorizontal * 0.35,
                      indent: blockSizeHorizontal * 4,
                      endIndent: blockSizeHorizontal * 55,
                    ),
                    Center(
                      child: Text(
                        'or',
                        style: TextStyle(
                          fontSize: blockSizeHorizontal * 5,
                          fontFamily: 'NunitoSansLight',
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xffbb5e1e),
                      thickness: blockSizeHorizontal * 0.35,
                      indent: blockSizeHorizontal * 55,
                      endIndent: blockSizeHorizontal * 4,
                    ),
                  ],
                ),
              ],
            ),

            Text(
              'Sign in with',
              style: TextStyle(
                fontSize: blockSizeHorizontal * 5,
                fontFamily: 'NunitoSansLight',
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

              // // Sign in with Facebook yet to be implemented
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => {},
                      child: Container(
                        height: blockSizeHorizontal * 30,
                        width: blockSizeHorizontal * 15,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[600],
                              width: blockSizeHorizontal * 0.4,
                            ),
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/facebook.jpg'),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Sign in with Google yet to be implemented
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => {},
                      child: Container(
                        height: blockSizeHorizontal * 30,
                        width: blockSizeHorizontal * 15,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[600],
                              width: blockSizeHorizontal * 0.4,
                            ),
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage('assets/google.jpg'),
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
    );
  }
}
