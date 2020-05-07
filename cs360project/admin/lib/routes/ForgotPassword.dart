import 'package:flutter/material.dart';
import 'package:admin/pin_entry_text_field.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart' ;
import 'dart:async';
import 'package:validators/validators.dart' ;
import 'dart:collection';
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

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

  AlertDialog display_result(String message) {
    AlertDialog alert = AlertDialog (
      content: Text(message),
    ) ;

    return alert ;
  }

  String username ;
  String email ;
  String mobile ;
  var body ;

  var forget_url = 'http://mr-fluffy-fluffs.herokuapp.com/api/admin/forget' ;

  Future <dynamic> forgot() async {
    var response = await Requests.post(
        forget_url,
        body: body,
        timeoutSeconds: 25,
        bodyEncoding: RequestBodyEncoding.JSON
    ) ;

    dynamic j = response.json() ;
    return j ;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>() ;

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
            Navigator.of(context).pushReplacementNamed('/login_screen') ;
          },
          child: Icon(
            Icons.keyboard_arrow_left,
            size: blockSizeHorizontal * 10,
            color: Color(0xffbb5e1e),
          ),
        ),
      ),

      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            SizedBox(height: blockSizeHorizontal * 4),

            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  Center(
                    child: Container(
                      color: Colors.white,
                      width: blockSizeHorizontal * 90,
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Username can't be empty" ;
                          }

                          if (value.length < 3) {
                            return "Username can't be less than 3 charachters" ;
                          }

                          if (isInt(value)) {
                            return "Username can't contain integers only" ;
                          }

                          return null ;
                        },
                        autofocus: true,
                        onChanged: (String user){
                          setState(() {
                            username = user ;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Username",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: blockSizeHorizontal * 6,
                            fontFamily: 'NunitoSansLight',
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: blockSizeHorizontal * 4),

                  Container(
                    width: blockSizeHorizontal * 90,
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Email can't be empty" ;
                        }

                        if(!isEmail(value)) {
                          return "Enter a valid email address" ;
                        }

                        return null ;
                      },
                      autofocus: true,
                      onChanged: (String em){
                        setState(() {
                          email = em ;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: blockSizeHorizontal * 6,
                          fontFamily: 'NunitoSansLight',
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: blockSizeHorizontal * 4),

                  Container(
                    width: blockSizeHorizontal * 90,
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Phone number can't be empty" ;
                        }

                        if (value.length < 11) {
                          return "Phone number can't be less than 11 digits" ;
                        }

                        if (isAlpha(value)) {
                          return "Phone number can't contain letters" ;
                        }

                        return null ;
                      },
                      autofocus: true,
                      onChanged: (String mob){
                        setState(() {
                          mobile = mob ;
                          mobile = mobile.substring(1) ;
                          mobile = '+92' + mobile ;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Phone number",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: blockSizeHorizontal * 6,
                          fontFamily: 'NunitoSansLight',
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: blockSizeHorizontal * 8),

                  ProgressButton(
                    animate: true,
                    color: Color(0xffbb5e1e),
                    defaultWidget: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: blockSizeHorizontal * 6,
                        fontFamily: 'NunitoSansSemiBold',
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
                      bool verified = false ;

                      if (_formKey.currentState.validate()) {
                        verified = true ;
                        body = { "admin":{ "Username":username, "Email":email, "MobileNo":mobile } } ;
                        resp = await Future.delayed(
                            const Duration(milliseconds: 6000), () => forgot()) ;
                      }

                      // After [onPressed], it will trigger animation running backwards, from end to beginning
                      return () {

                        if (resp['status'] == 'False') {
                          AlertDialog msg = display_result(resp['msg']) ;
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                          return msg ;
                            },
                          ) ;
                        }

                        else if (resp['status'] == 'True') {
                          Navigator.of(context).pushReplacementNamed('/forgotpassword_screen1',
                          arguments: {
                            'code': resp['code'],
                            'number': mobile
                          }) ;
                        }

                        else {
                          // do nothing as form data has not been validated
                        }

                      };
                    },
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

