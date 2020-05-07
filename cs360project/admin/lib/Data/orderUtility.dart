// This file contains utility functions for order management

import 'dart:async';
import 'dart:collection';
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;
import 'package:admin/Data/menuItems.dart';

var orderUrl = 'http://mr-fluffy-fluffs.herokuapp.com/api/admin/orders' ;

List history ; // All purchases
List <Map> ordersDone = []; // Orders that have been completed
List <Map> ordersPending = []; // Orders that are pending
bool historyStatus ; // Whether available or not

// to get admin name
Future <void> getOrders() async {
  var response = await Requests.get(
    orderUrl,
  );
  response.raiseForStatus();

  dynamic j = response.json() ;

  if (j['status'] == 'False') {
    // Do nothing
    historyStatus = false ;
  }

  else {
    historyStatus = true ;
    history = j['msg'] as List ;

    // filtering completed orders
    ordersDone = List() ;
    ordersPending = List() ;
    for(dynamic item in history){
      if (item['Status'] == 'Completed') {
        ordersDone.add(item) ;
      }
      else {
       ordersPending.add(item) ;
      }
    }
  }

  return j ;
}

var patchURL = 'http://mr-fluffy-fluffs.herokuapp.com/api/admin/orders/' ;

Future <dynamic> confirmOrder(id, b) async {
  var response = await Requests.patch(
      patchURL + id,
      body: b,
      timeoutSeconds: 25,
      bodyEncoding: RequestBodyEncoding.JSON
  ) ;

  dynamic j = response.json() ;

  return j ;
}