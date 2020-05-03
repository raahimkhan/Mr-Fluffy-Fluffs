import 'package:flutter/material.dart';

class Service extends StatelessWidget {

  final TextEditingController emailController = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    // Variables for adjusting Screen width and Height according to different sizes

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
                  child: SwitchWidget(),
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
                    fontSize: blockWidth * 5,
                    color: Color(0xffbb5e1e),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: blockWidth * 2),
                  child: SwitchWidget(),
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
                    fontSize: blockWidth * 5,
                    color: Color(0xffbb5e1e),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: blockWidth * 2),
                  child: SwitchWidget(),
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
                  child: SwitchWidget(),
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
    @override
    SwitchWidgetClass createState() => new SwitchWidgetClass();
  }
  
class SwitchWidgetClass extends State {
 
  bool switchControl = true;
 
  void toggleSwitch(bool value) {
 
      if(switchControl == false)
      {
        setState(() {
          switchControl = true;
        });
        print('Switch is ON');
        // Put your code here which you want to execute on Switch ON event.
 
      }
      else
      {
        setState(() {
          switchControl = false;
        });
        print('Switch is OFF');
        // Put your code here which you want to execute on Switch OFF event.
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
