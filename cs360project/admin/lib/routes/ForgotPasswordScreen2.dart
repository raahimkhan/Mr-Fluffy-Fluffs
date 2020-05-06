import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart' ;
import 'package:validators/validators.dart' ;
import 'dart:collection';
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;

class ForgotPasswordScreen2 extends StatefulWidget {
  @override
  _ForgotPasswordScreen2State createState() => _ForgotPasswordScreen2State();
}

class _ForgotPasswordScreen2State extends State<ForgotPasswordScreen2> {

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

  String password ;
  String password2 ;

  var body ;

  var patch_url = 'http://mr-fluffy-fluffs.herokuapp.com/api/admin/verify-forget' ;

  Future <dynamic> change_password() async {
    var response = await Requests.patch(
        patch_url,
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
                        obscureText: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Password can't be empty" ;
                          }

                          if (value.length < 8) {
                            return "Password can't be less than 8 charachters" ;
                          }
                          return null ;
                        },
                        autofocus: true,
                        onChanged: (String pw){
                          setState(() {
                            password = pw ;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "New Password",
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
                      obscureText: true,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "This field can't be empty" ;
                        }

                        if (value.length < 8 || password2 != password) {
                          return "Passwords don't match" ;
                        }
                        return null ;
                      },
                      autofocus: true,
                      onChanged: (String pw2){
                        setState(() {
                          password2 = pw2 ;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
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
                      'Change Password',
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
                      if (_formKey.currentState.validate()) {
                        body = { "admin":{ "PassHash":password} } ;
                        resp = await Future.delayed(
                            const Duration(milliseconds: 5000), () => change_password()) ;
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
                          AlertDialog msg = display_result(resp['msg']) ;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return msg ;
                            },
                          ) ;
                          Navigator.of(context).pushReplacementNamed('/login_screen') ;
                        }

                        else {
                          // Do nothing as form data has not been validated yet
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
