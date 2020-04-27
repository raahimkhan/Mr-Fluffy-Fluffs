import 'package:flutter/material.dart';
import 'package:fluffs/routes/LoadingScreen.dart';
import 'package:fluffs/routes/OpeningScreen.dart';
import 'package:fluffs/routes/LoginScreen.dart';
import 'package:fluffs/routes/SignupScreen1.dart';
import 'package:fluffs/routes/SignupScreen2.dart';
import 'package:fluffs/routes/SignupScreen3.dart';
import 'package:fluffs/routes/ForgotPasswordScreen1.dart';
import 'package:fluffs/routes/ForgotPasswordScreen2.dart';
import 'package:fluffs/routes/home.dart';
import 'package:fluffs/profile.dart';
import 'package:fluffs/menu_1.dart' ;
import 'package:fluffs/cart_1.dart' ;

// Main only contains the routes that are in this application.
// Routes are basically the different screens
// name_of_route: (context) => function_name
// Loading Screen is the root route meaning it will be displayed once application starts initially

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => LoadingScreen(),
    '/opening_screen': (context) => OpeningScreen(),
    '/login_screen': (context) => LoginScreen(),
    '/signup_screen1': (context) => SignupScreen1(),
    '/signup_screen2': (context) => SignupScreen2(),
    '/signup_screen3': (context) => SignupScreen3(),
    '/forgotpassword_screen1': (context) => ForgotPasswordScreen1(),
    '/forgotpassword_screen2': (context) => ForgotPasswordScreen2(),
    '/home_screen': (context) => Home(),
    '/profile': (context) => Profile(),
    '/menu_1': (context) => Menu(),
    '/cart_1': (context) => Cart()
  },
)) ;
