import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart' ;
import 'dart:async' ;

//This is an official flutter package/library
// Code was forked from here: https://github.com/prestigegodson/pin-entry-text-field/blob/master/pin_entry_text_field/lib/pin_entry_text_field.dart
// Dependency has been added to yaml file
import 'package:fluffs/pin_entry_text_field.dart';

class ForgotPasswordScreen1 extends StatefulWidget {
  @override
  _ForgotPasswordScreen1State createState() => _ForgotPasswordScreen1State();
}

class _ForgotPasswordScreen1State extends State<ForgotPasswordScreen1> {

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

  int pin ;

  AlertDialog alert = AlertDialog (
    content: Text("Invalid Pin!"),
  ) ;

  AlertDialog alertempty = AlertDialog (
    content: Text("Please enter complete pin!"),
  ) ;

  int check (int code) {

    String str = code.toString() ;
    int length = str.length ;
    print(length) ;

    if (length != 5) {
      return 2 ;
    }

    if (code == 12345) {
      return 1 ; // valid
    }

    else  {
      return 0 ; // not valid
    }
  }

  @override
  Widget build(BuildContext context) {
    init() ;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
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
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    Text(
                      'Please Enter the 5-digit',
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
                      'on your Email',
                      style: TextStyle(
                        fontSize: 38,
                        fontFamily: 'NunitoSansSemiBold',
                        color: Color(0xffbb5e1e),
                      ),
                    ),

                    SizedBox(height: 43) ,

                    PinEntryTextField(
                      fields: 5,
                      showFieldAsBox: false,
                      onSubmit: (String p) {
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
                        int status = 2 ;
                        status = await Future.delayed(
                            const Duration(milliseconds: 3000), () => check(pin)) ;


                        // After [onPressed], it will trigger animation running backwards, from end to beginning
                        return () {
                          if (status == 2) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alertempty ;
                              },
                            ) ;
                          }

                          else if (status == 1) {
                            print('Welcome') ;
                            Navigator.of(context).pushReplacementNamed('/forgotpassword_screen2') ;
                          }

                          else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert ;
                              },
                            ) ;
                          }

                        };
                      },
                    ),

                    SizedBox(height: 20) ,

                    FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Resend Email',
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
          ),


        ],
      ),
    );
  }
}
