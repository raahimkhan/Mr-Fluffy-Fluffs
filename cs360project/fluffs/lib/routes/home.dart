import 'package:flutter/material.dart';
import 'package:fluffs/cart_1.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluffs/menu_1.dart';
import 'package:fluffs/profile.dart';
import 'package:fluffs/extra.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    // These variables are used for adjusting the Screen width and height according to different sizes

    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;

    return Material(

      // A column Widget which takes in all the other wigets.
      
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: blockHeight * 2.8),

      // Inside a column widget, first of all a row widget is added inside of which there are two further row widgets. This is done so the 
      // icon widgets(Profile, Leaderboard, Cart) can easily be aligned in their appropriate places.  

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,MaterialPageRoute(
                            builder: (context) => Profile(),
                          ),
                        );
                      },
                      icon: Icon(Icons.person),
                      color: Colors.red[200],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () {
                          print("Leaderboard");
                        },
                        icon: Icon(
                          FontAwesomeIcons.crown,),
                        color: Colors.red[200],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton( 
                      onPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) => Cart(),
                          ),
                        );
                      },
                      icon: Stack(
                        children: <Widget>[
                          Icon(Icons.shopping_cart),
                          // For Notification Bar 
                          if (bloc.allItems.length > 0)  
                          Padding(
                            padding: EdgeInsets.only(left: blockWidth * 0.2),
                            child: CircleAvatar(
                              radius: blockWidth * 2,
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              child: Text(
                                bloc.allItems.length.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: blockWidth * 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      color: Colors.red[200],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Another row widget is used to place the image in the correct position

          SizedBox(height: blockHeight * 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Container(
               child: SizedBox(
                  height: blockHeight * 25,
                  child: Image(
                    image: AssetImage(
                     "assets/pc.png",
                   ),
                 ),
               ),
             ),   
            ],
          ),
          SizedBox(height: blockHeight * 4),

          // For placing the buttons, a List View was used along with the Center widget. Each button allows the user to go to multiple screens  

          Flexible(
            child: ListView(
              children: <Widget>[
                Center(
                    child: SizedBox(
                        width: blockWidth * 70,
                        height: blockHeight * 7, 
                        child: RaisedButton.icon(
                        onPressed: (){
                          Navigator.push(
                            context,MaterialPageRoute(
                              builder: (context) => Menu(),
                            ),
                          );
                        }, 
                        icon: Icon(Icons.fastfood), 
                        color: Color(0xffbb5e1e),
                        label: Text("Menu",
                        style: TextStyle(
                          fontSize: blockWidth * 3,
                          color: Colors.white,
                          fontFamily: 'NunitoSansSemiBold',
                        )),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(blockWidth * 4)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: blockHeight * 2),
                Center(
                    child: SizedBox(
                        width: blockWidth * 70,
                        height: blockHeight * 7, 
                        child: RaisedButton.icon(
                        onPressed: (){
                          print("Customizer Lad");
                        },
                        icon: Icon(Icons.receipt), 
                        color: Color(0xffbb5e1e),
                        label: Text("Create your Own Pancake",
                        style: TextStyle(
                          fontSize: blockWidth * 3,
                          color: Colors.white,
                          fontFamily: 'NunitoSansSemiBold',
                        )),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(blockWidth * 4)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: blockHeight * 2),
                Center(
                    child: SizedBox(
                        width: blockWidth * 70,
                        height: blockWidth * 12,
                        child: RaisedButton.icon(
                        onPressed: (){
                          print("Community Pancake");
                        }, 
                        icon: Icon(Icons.star), 
                        color: Color(0xffbb5e1e),
                        label: Text("Community Made Pancakes",
                        style: TextStyle(
                          fontSize: blockWidth * 3,
                          color: Colors.white,
                          fontFamily: 'NunitoSansSemiBold',
                        )),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(blockWidth * 4)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: blockHeight * 3),
                lines(blockWidth),
                SizedBox(height: blockHeight * 0.2),
                Center(
                child: Text(
                  "For any queries call us on",
                  style: TextStyle(
                    fontSize: blockWidth * 4,
                    color: Colors.black
                )),
              ),
              Center(
                child: Text(
                  "+923009495206",
                  style: TextStyle(
                    fontSize: blockWidth * 4,
                    color: Colors.orange,
                )),
              ),
              ],
            ),
          ),
        ],
      ), 
    );
  }
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