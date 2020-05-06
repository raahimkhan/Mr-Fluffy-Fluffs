import 'package:flutter/material.dart';
import 'package:fluffs/cart_1.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluffs/menu.dart';
import 'package:fluffs/profile.dart';
import 'package:fluffs/extra.dart';
import 'package:fluffs/Data/details.dart';
import 'dart:async';
import 'dart:collection';
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

bool customStatus ; // true or false depending on custom pancakes services are available or not
bool menuStatus ; // true or false depending on menu services are available or not
bool communityStatus ; // true or false depending on community pancakes services are available or not
bool leaderStatus ; // true or false depending on leader board services are available or not

class _HomeState extends State<Home> {

  var services_url = 'http://mr-fluffy-fluffs.herokuapp.com/api/common/services' ;

  Future <void> get_services() async {
    var response = await Requests.get(
      services_url,
    );
    response.raiseForStatus();

    dynamic resp = response.json() ;

    List data =  resp as List ;

    customStatus = data[0]['Status'] ;
    menuStatus = data[1]['Status'] ;
    leaderStatus = data[2]['Status'] ;
    communityStatus = data[3]['Status'] ;
  }

  AlertDialog display_result(String message) {
    AlertDialog alert = AlertDialog (
      content: Text(message),
    ) ;

    return alert ;
  }

  var status_url = 'http://mr-fluffy-fluffs.herokuapp.com/api/user/' ;
  String type ; // Can be either 'Guest' or a registered user

  // to check whether guest is logged in or a registered user
  Future <void> check_status() async {
    var response = await Requests.get(
      status_url,
    );
    response.raiseForStatus();

    dynamic j = response.json() ;

    if (j['msg'].contains('You must be logged in to access this feature')) {  // guest is logged in
      type = 'Guest' ;

      // This data is being provided to the 'details.dart' screen which further supplies the data to cart screen
      detailsPhone = '-' ;
      detailsAddress = '-' ;
    }

    else { // user is logged in
      dynamic data = j['data'] ;
      type = data['FullName'] ;

      // This data is being provided to the 'details.dart' screen which further supplies the data to cart screen
      detailsPhone = data['MobileNo'] ;
      detailsAddress = data['Address'] ;
    }
  }

  @override
  Widget build(BuildContext context) {

    // These variables are used for adjusting the Screen width and height according to different sizes

    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;

    get_services() ;
    check_status() ;

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
                          // Guest cannot use 'Create your onw pancake' or 'Custom pancake' feature
                          if (type == 'Guest') {
                            AlertDialog msg = display_result('Please register to use this feature.') ;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return msg ;
                              },
                            ) ;
                          }

                          // If user logged in then it depends whether service is available or unavailable

                          else {
                            if (leaderStatus == true) {
                              AlertDialog msg = display_result('Coming soon.') ;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return msg ;
                                },
                              ) ;
                            }

                            else {
                              AlertDialog msg = display_result('This service is currently unavailable.') ;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return msg ;
                                },
                              ) ;
                            }
                          }

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
                                  (bloc.allItems[bloc.allItems.length-1]['quan'] + bloc.allItems[bloc.allItems.length-1]['number']).toString(),
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
                  height: blockHeight * 30,
                  child: Image(
                    image: AssetImage(
                     "assets/pc.png",

                   ),


                 ),
               ),
             ),   
            ],
          ),
          SizedBox(height: blockHeight/100 ),

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

                          // If menu service is available user / guest would be routed to menu screen
                          if (menuStatus == true) {
                            Navigator.push(
                              context,MaterialPageRoute(
                              builder: (context) => Menu(),
                            ),
                            );
                          }

                          // If not available (e.g under maintenance) then a prompt will be displayed
                          else {
                            AlertDialog msg = display_result('This service is currently unavailable.') ;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return msg ;
                              },
                            ) ;
                          }
                        }, 
                        icon: Icon(Icons.fastfood,
                        color: Colors.white),
                        color: Color(0xffbb5e1e),
                        label: Text("Menu",
                        style: TextStyle(
                          fontSize: blockWidth * 3,
                          color: Colors.white,
                          fontFamily: 'NunitoSansSemiBold',
                        )),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(blockWidth * 100)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: blockHeight * 3),
                Center(
                    child: SizedBox(
                        width: blockWidth * 70,
                        height: blockHeight * 7,
                        child: RaisedButton.icon(
                        onPressed: (){

                          // Guest cannot use 'Create your onw pancake' or 'Custom pancake' feature
                          if (type == 'Guest') {
                            AlertDialog msg = display_result('Please register to use this feature.') ;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return msg ;
                              },
                            ) ;
                          }

                          // If user logged in they will be delivered message according to whether service is available or not
                          else {
                            if (customStatus == true) {
                              AlertDialog msg = display_result('Coming soon!') ;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return msg ;
                                },
                              ) ;
                            }

                            else {
                              AlertDialog msg = display_result('This service is currently unavailable.') ;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return msg ;
                                },
                              ) ;
                            }
                          }

                        },
                        icon: Icon(Icons.receipt,
    color: Colors.white),
                        color: Color(0xffbb5e1e),
                        label: Text("Create your Own Pancake",
                        style: TextStyle(
                          fontSize: blockWidth * 3,
                          color: Colors.white,
                          fontFamily: 'NunitoSansSemiBold',
                        )),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(blockWidth * 100)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: blockHeight * 3),
                Center(


                    child: SizedBox(
                        width: blockWidth * 70,
                        height: blockWidth * 13.5,
                        child: RaisedButton.icon(
                        onPressed: (){

                          // Guest cannot use community made pancakes feature

                          if (type == 'Guest') {
                            AlertDialog msg = display_result('Please register to use this feature.') ;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return msg ;
                              },
                            ) ;
                          }

                          // If user logged in then it depends whether service is available or unavailable

                          else {
                            if (communityStatus == true) {
                              AlertDialog msg = display_result('Coming soon.') ;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return msg ;
                                },
                              ) ;
                            }


                            else {
                              AlertDialog msg = display_result('This service is currently unavailable.') ;
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return msg ;
                                },
                              ) ;
                            }
                          }

                        }, 
                        icon: Icon(Icons.star,
    color: Colors.white,),
                        color: Color(0xffbb5e1e),
                        label: Text("Community Made Pancakes",
                        style: TextStyle(
                          fontSize: blockWidth * 3,
                          color: Colors.white,
                          fontFamily: 'NunitoSansSemiBold',
                        )),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(blockWidth * 100)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: blockHeight*15 ),
                lines(blockWidth),
                SizedBox(height: blockHeight * 0.2),
                Center(
                child: Text(
                  "For any queries call us on",
                  style: TextStyle(
                    fontSize: blockWidth * 4,
                    color: Colors.black,
                      fontFamily: 'NunitoSansLight',
                )),
              ),
              Center(
                child: Text(
                  "+923009495206",
                  style: TextStyle(
                    fontSize: blockWidth * 4,
                    color: Colors.orange,
                    fontFamily: 'NunitoSansLight',
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