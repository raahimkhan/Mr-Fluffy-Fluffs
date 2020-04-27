import 'package:flutter/material.dart' ;
import 'dart:async';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => new _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  timer() async {
    // call back function. switchScreen is called after 10 seconds
    return Timer(Duration(seconds: 5), switchScreen);
  }

  void switchScreen() {
    Navigator.of(context).pushReplacementNamed('/opening_screen');
  }

  @override
  void initState() {
    super.initState();
    timer();
  }

  double screenWidth;
  double screenHeight;
  double blockSizeHorizontal;
  double blockSizeVertical;

  void init() {
    screenWidth = MediaQuery.of(context).size.width ;
    screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight ;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  @override
  Widget build(BuildContext context) {
    init() ;
    return new Scaffold(
      body: Center(
        child: Container(
            height: blockSizeVertical *100,
            width: blockSizeHorizontal * 100,
            color: Colors.white,
            child: Align(
                alignment: Alignment(-1.2, -0.5),
                child: Image.asset('assets/loading_screen.png', scale: 2.5)
            )
        ),
      ),
    );
  }
}