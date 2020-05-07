// This file contains utility functions for menu management e.g add new item, delete item, fetch item

import 'dart:convert';
import 'dart:async';
import 'dart:collection';
import 'package:http/http.dart' as http ;
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;

List menuItems ; // This list will contain all the menu items present at the backend (admin side)

String url = 'http://mr-fluffy-fluffs.herokuapp.com/api/common/menu';

Future<dynamic> fetchMenu() async {
  Map<String, String> headers = new HashMap();
  headers.putIfAbsent('Accept', () => 'application/json');

  http.Response response = await http.get(
    url,
    headers: headers,
  );

  dynamic resp = jsonDecode(response.body) ;

  menuItems =  resp as List ;

  return resp ;
}

String url2 = 'http://mr-fluffy-fluffs.herokuapp.com/api/common/menu/';
Future<dynamic> deleteMenu(_id) async {
  Map<String, String> headers = new HashMap();
  headers.putIfAbsent('Accept', () => 'application/json');

  http.Response response = await http.delete(
    url2 + _id,
    headers: headers,
  );

  dynamic resp = jsonDecode(response.body) ;

  return resp ;
}

String url3 = 'http://mr-fluffy-fluffs.herokuapp.com/api/common/menu';
Future <dynamic> addMenu(Name,  Description,  Price) async {
  var response = await Requests.put(
      url3,
      body: { 'pancake':  {'Name':  Name, 'Description':  Description,  'Price':  Price} },
      bodyEncoding: RequestBodyEncoding.JSON
  ) ;

  dynamic j = response.json() ;
  return j ;
}

// Menu is in the following format
//[
  //{_id: 5eb0515005b8e000049d0f39, Name: Plain Fluffy Pancake, Description: A plain fluffy pancake, Price: 100, __v: 0, Path: http://mr-fluffy-fluffs.herokuapp.com/api/common/images/Plain Fluffy Pancake},
// {_id: 5eb0518105b8e000049d0f3a, Name: ChoclateChip Pancake, Description: A fluffy pancake filled with choclate chips, Price: 120, __v: 0, Path: http://mr-fluffy-fluffs.herokuapp.com/api/common/images/ChoclateChip Pancake},
// {_id: 5eb0518f05b8e000049d0f3b, Name: White ChoclateChip Pancake, Description: A fluffy pancake filled with white choclate chips, Price: 120, __v: 0, Path: http://mr-fluffy-fluffs.herokuapp.com/api/common/images/White ChoclateChip Pancake},
// {_id: 5eada835f5752f18c0b4e777, Name: Nutella Pancake, Description: Filled with Nutella, Price: 100, __v: 0, Path: http://mr-fluffy-fluffs.herokuapp.com/api/common/images/Nutella Pancake}
// ]
