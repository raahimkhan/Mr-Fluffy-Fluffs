import 'package:flutter/material.dart';
import 'package:admin/routes/LoadingScreen.dart';
import 'package:admin/routes/LoginScreen.dart';
import 'package:admin/routes/adminhome.dart' ;
import 'package:admin/routes/ForgotPassword.dart';
import 'package:admin/routes/ForgotPasswordScreen1.dart';
import 'package:admin/routes/ForgotPasswordScreen2.dart';
import 'package:admin/menuadd.dart' ;
import 'package:admin/menuremove.dart' ;

// Main only contains the routes that are in this application.
// Routes are basically the different screens
// name_of_route: (context) => function_name
// Loading Screen is the root route meaning it will be displayed once application starts initially

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => LoadingScreen(),
    '/login_screen': (context) => LoginScreen(),
    '/home_screen': (context) => AdminHome(),
    '/forgotpassword': (context) => ForgotPassword(),
    '/forgotpassword_screen1': (context) => ForgotPasswordScreen1(),
    '/forgotpassword_screen2': (context) => ForgotPasswordScreen2(),
    '/menu_add': (context) => MenuAdd(),
    '/menu_remove': (context) => MenuRemove(),
  },
)) ;
