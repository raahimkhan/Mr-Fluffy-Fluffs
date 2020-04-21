import 'package:flutter/material.dart' ;
import 'package:flutter_application/screens/loading_screen.dart';
import 'package:flutter_application/screens/opening_screen.dart';

//use the API instance | if u guys want to use it in this file
import 'package:flutter_application/Api.dart';

//also use the model objects to process model specific data with ease :)
import 'package:flutter_application/models/Customer.dart';


// This is the main file
// This will contain all the routes (changes between screens information)
// Any updates in this file shall be committed to 'frontend' branch only
// If new routes are added a separate branch shall be created for it
// Then work on that particular route will be committed to that branch only
// Final changes will be merged with 'frontend' branch in the end

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => LoadingScreen(),
    '/opening_screen': (context) => OpeningScreen()
  },
)) ;
