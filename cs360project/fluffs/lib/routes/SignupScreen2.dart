import 'package:flutter/material.dart';
import 'package:fluffs/pin_entry_text_field.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart' ;
import 'dart:async';

class SignupScreen2 extends StatefulWidget {
  @override
  _SignupScreen2State createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen2> {

  // screen details
  double screenWidth;
  double screenHeight;
  double blockSizeHorizontal;
  double blockSizeVertical;

  Map data = {} ;

  // Variables transfered from 'SignupScreen1'
  String username ;
  String password ;
  String fullname ;

  void init() {
    screenWidth = MediaQuery.of(context).size.width ;
    screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight ;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  int pin ;

  AlertDialog alert = AlertDialog (
    content: Text("Invalid Pin!"),
  ) ;

  AlertDialog alertempty = AlertDialog (
    content: Text("Please enter complete pin!"),
  ) ;

  @override
  Widget build(BuildContext context) {
    init() ;

    data = ModalRoute.of(context).settings.arguments ;
    username = data['type'] ;
    password = data['pass'] ;
    fullname = data['name'] ;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/signup_screen1') ;
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            size: 45,
            color: Color(0xffbb5e1e),
          ),
        ),
      ),

      body: Column(
        children: <Widget>[
          Container(
            height: blockSizeVertical * 40,
            width: blockSizeHorizontal * 100,
            color: Colors.white,
            child: Image.asset('assets/signuptwo.png'),
          ),

          Container(
            height: blockSizeVertical * 65,
            width: blockSizeHorizontal * 100,
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  Text(
                    'Please Enter the 6-digit',
                    style: TextStyle(
                      fontSize: 38,
                      fontFamily: 'NunitoSansSemiBold',
                      color: Color(0xffbb5e1e),
                    ),
                  ),

                  Text(
                    'verification code sent',
                    style: TextStyle(
                      fontSize: 38,
                      fontFamily: 'NunitoSansSemiBold',
                      color: Color(0xffbb5e1e),
                    ),
                  ),

                  Text(
                    'on your SMS',
                    style: TextStyle(
                      fontSize: 38,
                      fontFamily: 'NunitoSansSemiBold',
                      color: Color(0xffbb5e1e),
                    ),
                  ),

                  SizedBox(height: 43) ,

                  PinEntryTextField(
                    fields: 6,
                    showFieldAsBox: false,
                    onSubmit: (String p) {
                      p = p.substring(1) ;
                      p = '+92' + p ;
                      pin = int.parse(p) ;
                    },
                  ),

                  SizedBox(height: 55) ,

                  ProgressButton(
                    animate: true,
                    color: Color(0xffbb5e1e),
                    defaultWidget: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23.0,
                        fontFamily: 'NunitoSansSemiBold',
                      ),
                    ),
                    progressWidget: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    width: 190,
                    height: 54,
                    borderRadius: 30.0,
                    onPressed: () async {
                        await Future.delayed(
                            const Duration(milliseconds: 2000), () => {}) ;


                      // After [onPressed], it will trigger animation running backwards, from end to beginning
                      return () {
                          Navigator.of(context).pushReplacementNamed('/signup_screen3',
                          arguments: {
                            'type': username,
                            'name': fullname,
                            'pass': password,
                          }) ;
                      };
                    },
                  ),

                  SizedBox(height: 20) ,

                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Resend SMS',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'NunitoSansLight',
                        color: Colors.black,
                      ),
                    ),
                  ),

                ]
            ),
          ),


        ],
      ),
    );
  }
}
