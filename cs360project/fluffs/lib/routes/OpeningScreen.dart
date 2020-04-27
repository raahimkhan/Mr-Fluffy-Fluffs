import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;
import 'dart:async';
import 'package:http/http.dart' as http ;
import 'dart:collection';
import 'package:flutter_progress_button/flutter_progress_button.dart' ;
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;

class OpeningScreen extends StatefulWidget {
  @override
  _OpeningScreenState createState() => new _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {

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
  Future <String> guest_login() async {
    var response = await Requests.post(
        url,
        body: {},
        bodyEncoding: RequestBodyEncoding.JSON
    ) ;
    response.raiseForStatus();


    dynamic j = response.json() ;
    return j['msg'] ;

    // response body contains status code telling true or false for successful or failed connections
    // msg tells the nature of the status code
  }

  @override
  Widget build(BuildContext context) {
    init() ;
    return Scaffold(
        resizeToAvoidBottomPadding: false, // prevents overflow (resize the widgets)
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            // Widget containing title and the logo
            Positioned(
                width: MediaQuery.of(context).size.width,
                top: MediaQuery.of(context).size.width * 0.1, // 10% of the screen reserved for title
                child: Container(
                  margin: EdgeInsets.all(26.0),
                  color: Colors.white,
                  child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        SizedBox(height: 20),

                        Text(
                            "Mr. Fluffy Fluffs",
                            style: TextStyle(
                                fontSize: 47.0, color: Color(0xffbb5e1e),fontFamily: 'NunitoSansLight')
                        ),

                        Container(
                          // Similarly height and width fixed for the logo
                          height: blockSizeVertical * 70,
                          width: blockSizeHorizontal * 100,
                          color: Colors.white,
                          child: Align(
                              alignment: Alignment(-2.4, -3.3),
                              child: Image.asset('assets/loading_screen.png', scale: 2.63)
                          ),
                        ),
                      ]
                  ),
                )
            ),

            Align(
              alignment: Alignment(0.0, -0.0), // 0.88, 0.4
              child: ProgressButton(
                animate: true,
                color: Color(0xffbb5e1e),
                defaultWidget: const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontFamily: 'NunitoSansSemiBold',
                    color: Colors.white,
                  ),
                ),

                // This is an animation widget which loads while the screen is traversed
                progressWidget: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                width: 230,
                height: 53,
                borderRadius: 30.0,
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

            Align(
              alignment: Alignment(0.0, 0.2), // 0.88, 0.4
              child: ProgressButton(
                animate: true,
                color: Color(0xffbb5e1e),
                defaultWidget: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontFamily: 'NunitoSansSemiBold',
                    color: Colors.white,
                  ),
                ),
                progressWidget: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                width: 230,
                height: 53,
                borderRadius: 30.0,
                onPressed: () async {
                  await Future.delayed(
                      const Duration(milliseconds: 2000), () => {}) ;
                  // After [onPressed], it will trigger animation running backwards, from end to beginning
                  return () {
                    Navigator.of(context).pushReplacementNamed('/signup_screen1') ;
                  };

                },
              ),
            ),

            Align(
              alignment: Alignment(0.0, 0.4), // 0.88, 0.4
              child: ProgressButton(
                animate: true,
                color: Color(0xffbb5e1e),
                defaultWidget: const Text(
                  'Log in as a guest',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'NunitoSansSemiBold',
                    color: Colors.white,
                  ),
                ),
                progressWidget: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                width: 230,
                height: 53,
                borderRadius: 30.0,
                onPressed: () async {
                  await Future.delayed(
                        const Duration(milliseconds: 2000), () => guest_login()) ;
                  // After [onPressed], it will trigger animation running backwards, from end to beginning
                  return () {
                    Navigator.of(context).pushReplacementNamed('/home_screen',
                    arguments: {
                      'type': 'Guest', // Here i am just sending type of user. There are two. Either guest or actual registered user.
                    }) ;
                  };
                },
              ),
            ),

            // This is a divider widget
            Align(
              alignment: Alignment(0.0, 0.6),
              child: Divider(
                color: Color(0xffbb5e1e),
                thickness: 1.2,
                indent: 30,
                endIndent: 235,
              ),
            ),

            Align(
              alignment: Alignment(0.0, 0.6),
              child: Text(
                'or',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'NunitoSansLight',
                ),
              ),
            ),

            Align(
              alignment: Alignment(0.0, 0.6),
              child: Divider(
                color: Color(0xffbb5e1e),
                thickness: 1.2,
                indent: 235,
                endIndent: 30,
              ),
            ),

            Align(
              alignment: Alignment(0.0, 0.71),
              child: Text(
                'Sign in with',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'NunitoSansLight',
                ),
              ),
            ),

            // Sign in with Facebook yet to be implemented
            Align(
              alignment: Alignment(-0.3, 0.93),
              child: GestureDetector(
                onTap: () => {},
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[600],
                        width: 3.6,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/facebook.jpg'),
                      )
                  ),
                ),
              ),
            ),

            // Sign in with Google yet to be implemented
            Align(
              alignment: Alignment(0.3, 0.93),
              child: GestureDetector(
                onTap: () => print('Heyy!'),
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[600],
                        width: 3.6,
                      ),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/google.jpg'),
                      )
                  ),
                ),
              ),
            ),

          ],
        )
    );
  }
}
