import 'package:flutter/material.dart' ;
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: LoadingScreen(),
  ));
}

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
    Navigator.of(context).pushReplacementNamed('/opening_screen'); // pushes route desired onto the stack
  }

  @override
  void initState() {
    super.initState();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 85.0, 45.0, 0.0),
        child: Image(
          image: AssetImage('assets/loading_screen.png'),
        )
      ),
    );
  }
}