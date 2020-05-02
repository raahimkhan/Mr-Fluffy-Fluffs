import 'package:flutter/material.dart';
import 'package:se7/servicemanage.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

// Multiple Column and Row Widgets were used here to make the Screen
// Multiple manually constucted widgets were also created 

class _AdminHomeState extends State<AdminHome> {

  String name = "Aiyan Tufail";

  @override
  Widget build(BuildContext context) {
    
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return Material(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: blockWidth * 15),
            child: Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  profileIcon(blockWidth),
                ],
              ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, blockHeight * 2, 0, blockHeight * 2),
                child: Text(
                name,
                style: TextStyle(
                  fontSize: blockWidth * 7,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[400],
                ),
                textAlign:TextAlign.center,
                ),
              ),
              lines(blockWidth),
              tiles("Order Management", Service()),
              lines(blockWidth),
              tiles("Menu Management", Service()),
              lines(blockWidth),
              tiles("Service Management", Service()),
              lines(blockWidth),
              FlatButton(
                onPressed: () {
                  print("Log Out");
                },
                textColor: Colors.red[400],
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    fontSize: blockWidth * 4,
                  ),
                )
              ),
              lines(wTH),
            ],
          ),
        ],
      ),
    );
  }
}

// This is a manually constructed widget that places the profile icon and creates a circular border around the icon

Widget profileIcon(wTH) {
  return Container(
        padding: EdgeInsets.all(wTH * 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(wTH * 16),
            border: Border.all(width: wTH * 0.5, color: Colors.brown[200])),
        child: Icon(
          Icons.person,
          color: Colors.brown[600],
          size: wTH * 16, 
        ),
  );
}

// This is a manually constructed widget that is used for creating same type of buttons

Widget tiles(String name, Widget wid) {
  return Builder(
      builder: (BuildContext context) {
        var wTH = MediaQuery.of(context).size.width;
        var blockWidth = wTH / 100;
        return FlatButton(
          onPressed: () {
            Navigator.push(
              context,MaterialPageRoute(
                builder: (context) => wid,
              ),
            );
          },
          textColor: Colors.brown[400],
          child: Text(
            name,
            style: TextStyle(
              fontSize: blockWidth * 4,
            ),
          )
        );
    }
  );
}

// This is a manually constructed Widget which is used to add a divider between the buttons and the next few lines of Text

Widget lines(wTH) {
  return Divider(
    thickness: 0.4,
    color: Colors.black,
    indent: wTH * 4,
    endIndent: wTH * 5,
  );
}
