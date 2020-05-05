import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:collection';
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;

var services_url = 'http://mr-fluffy-fluffs.herokuapp.com/api/common/services' ;

//Future <void> get_services() async {
//  var response = await Requests.get(
//    services_url,
//  );
//  response.raiseForStatus();
//
//  dynamic resp = response.json() ;
//
//  print(resp) ;
//}

class Service extends StatelessWidget {

  final TextEditingController emailController = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    // Variables for adjusting Screen width and Height according to different sizes

    //get_services() ;

    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        child: Column(
          children: <Widget>[

            // Rows were used here to correctly position the icons and the search bars

            Padding(
              padding: EdgeInsets.only(top: blockHeight * 2.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.keyboard_arrow_left),
                    color: Colors.red[200],
                  ),
                ],
              ),
            ),
            Container(
              width: blockWidth * 80,
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(
                     color: Colors.brown[200], 
                     width: blockWidth * 0.3,
                   ),
                   borderRadius: BorderRadius.circular(blockWidth),
                  ),
                  hintText: "Services",
                  suffixIcon: IconButton(
                    onPressed: (){
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            ServiceMenu(),
          ],
        ),
      ),
    );
  }
}

class ServiceMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return Material(
      child: Column(
        children: <Widget>[
          SizedBox(height: blockHeight * 3),
          lines(blockWidth),
          SizedBox(height: blockHeight * 1),
          Padding(
            padding: EdgeInsets.only(left: blockWidth * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: blockWidth * 6,
                    color: Color(0xffbb5e1e),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: blockWidth * 2),

                  child: SwitchWidget('Menu'),
                ),
              ],
            ),
          ),
          SizedBox(height: blockHeight * 1),
          lines(blockWidth),
          SizedBox(height: blockHeight * 1),
          Padding(
            padding: EdgeInsets.only(left: blockWidth * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Custom Pancakes",
                  style: TextStyle(
                    fontSize: blockWidth * 6,
                    color: Color(0xffbb5e1e),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: blockWidth * 2),
                  child: SwitchWidget('Custom Pancakes'),
                ),
              ],
            ),
          ),
          SizedBox(height: blockHeight * 1),
          lines(blockWidth),
          SizedBox(height: blockHeight * 1),
          Padding(
            padding: EdgeInsets.only(left: blockWidth * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Community Pancakes",
                  style: TextStyle(
                    fontSize: blockWidth * 6,
                    color: Color(0xffbb5e1e),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: blockWidth * 2),
                  child: SwitchWidget('Community Pancakes'),
                ),
              ],
            ),
          ),
          SizedBox(height: blockHeight * 1),
          lines(blockWidth),
          SizedBox(height: blockHeight * 1),
          Padding(
            padding: EdgeInsets.only(left: blockWidth * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Leaderboard",
                  style: TextStyle(
                    fontSize: blockWidth * 6,
                    color: Color(0xffbb5e1e),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: blockWidth * 2),
                  child: SwitchWidget('Leaderboard'),
                ),
              ],
            ),
          ),
          SizedBox(height: blockHeight * 1),
          lines(blockWidth),
        ],
      ),
    );
  }
}

 class SwitchWidget extends StatefulWidget {

   String serviceType ;

   SwitchWidget(String serviceType) {
     this.serviceType = serviceType ;
   }

    @override
    SwitchWidgetClass createState() => new SwitchWidgetClass(serviceType);
  }

  // This function toggles the selected service on or off
var patch_url = 'http://mr-fluffy-fluffs.herokuapp.com/api/common/services/' ;
Future <void> toggleService(name, body) async {
  var response = await Requests.patch(
      patch_url + name,
      body: body,
      bodyEncoding: RequestBodyEncoding.JSON
  ) ;

  dynamic j = response.json() ;
}
  
class SwitchWidgetClass extends State {

  String serviceType ;  // Menu, Custom Pancakes, Community Pancakes, Leaderboard

  SwitchWidgetClass(String serviceType) {
    this.serviceType = serviceType ;
  }

  AlertDialog display_result(String message) {
    AlertDialog alert = AlertDialog (
      content: Text(message),
    ) ;

    return alert ;
  }
 
  bool switchControl = true;
 
  void toggleSwitch(bool value) {

      if(switchControl == false)
      {
        setState(() {
          switchControl = true;
        });

        // Put your code here which you want to execute on Switch ON event.

        if (this.serviceType == 'Menu') {
          var body = { 'service': {'Status': true} };
          toggleService('5eb068da9a36954d94fdfb02', body) ;
        }

        else if (this.serviceType == 'Custom Pancakes') {
          var body = { 'service': {'Status': true} };
          toggleService('5e9efed8eb2b5c27128eeeb4', body) ;
        }

        else if (this.serviceType == 'Community Pancakes') {
          var body = { 'service': {'Status': true} };
          toggleService('5eb159176bad5000047a291d', body) ;
        }

        else if (this.serviceType == 'Leaderboard') {
          var body = { 'service': {'Status': true} };
          toggleService('5eb159056bad5000047a291c', body) ;
        }

        AlertDialog msg = display_result('Service enabled.') ;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return msg ;
          },
        ) ;
 
      }
      else
      {
        setState(() {
          switchControl = false;
        });
        // Put your code here which you want to execute on Switch OFF event.

        if (this.serviceType == 'Menu') {
          var body = { 'service': {'Status': false} };
          toggleService('5eb068da9a36954d94fdfb02', body) ;
        }

        else if (this.serviceType == 'Custom Pancakes') {
          var body = { 'service': {'Status': false} };
          toggleService('5e9efed8eb2b5c27128eeeb4', body) ;
        }

        else if (this.serviceType == 'Community Pancakes') {
          var body = { 'service': {'Status': false} };
          toggleService('5eb159176bad5000047a291d', body) ;
        }

        else if (this.serviceType == 'Leaderboard') {
          var body = { 'service': {'Status': false} };
          toggleService('5eb159056bad5000047a291c', body) ;
        }

        AlertDialog msg = display_result('Service disabled.') ;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return msg ;
          },
        ) ;
      }
  }
  
    @override
    Widget build(BuildContext context) {
      var wTH = MediaQuery.of(context).size.width;
      var blockWidth = wTH / 100;
      return Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              children:[ Transform.scale( 
              scale: blockWidth * 0.44,
              child: Switch(
              onChanged: toggleSwitch,
              value: switchControl,
              activeColor: Colors.white,
              activeTrackColor: Color(0xffbb5e1e),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey,
            )
          ),  
      ]);
  }
}

Widget lines(wTH) {
  return Divider(
    thickness: 0.4,
    color: Colors.black,
    indent: wTH * 4,
    endIndent: wTH * 5,
  );
}
