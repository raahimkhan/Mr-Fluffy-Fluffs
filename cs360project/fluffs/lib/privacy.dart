import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;

    String username = "Aiyo6";
    String fname = "Aiyan Tufail";
    String email = "aiyan@gmail.com";
    String password = "******";
    String address = "114 DHA Lahore";
    int phone = 03214055195;

    return Material(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: blockHeight * 2.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.keyboard_arrow_left),
                  color: Colors.red[400],
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                lines(blockWidth),
                section("Username", username),
                lines(blockWidth),
                section("Full Name", fname),
                lines(blockWidth),
                section("Email", email),
                lines(blockWidth),
                section("Password", password),
                lines(blockWidth),
                section("Address", address),
                lines(blockWidth),
                section("Phone Number", phone),
                lines(blockWidth),
                Card(
                  child: Center(
                    child: SizedBox(
                      width: blockWidth * 40,
                      height: blockHeight * 6,
                      child: RaisedButton(
                        onPressed: (){
                          print("Save Button");
                        },
                        textColor: Colors.white,
                        color: Color(0xffbb5e1e),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: blockWidth * 4,
                            fontFamily: 'NunitoSans-SemiBold',
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(blockWidth * 6)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ),
          ],
        ),
    );
  }
}

Widget section(p1, p2) {
  return Builder(
    builder: (BuildContext context) {
      var wTH = MediaQuery.of(context).size.width;
      var blockWidth = wTH / 100;
      var hTH = MediaQuery.of(context).size.height;
      var blockHeight = hTH / 100;
      return ListTile(
        title: Text(
          p1,
          style: TextStyle(
            fontSize: blockWidth * 4,
            fontWeight: FontWeight.bold,
            color: Colors.brown[400],
          ),
        ),
        subtitle: Text(
          "$p2",
            style: TextStyle(
            fontSize: blockWidth * 3,
            color: Colors.brown[200],
          ),
        ),
        trailing: IconButton(
          onPressed: (){
            print("Edit Settings");
          },
          icon: Icon(Icons.edit),
          color: Colors.red,
        ),
      );
    }
  );
}

Widget lines(wTH) {
  return Divider(
    thickness: 0.4,
    color: Colors.black,
    indent: wTH * 4,
    endIndent: wTH * 5,
  );
}

