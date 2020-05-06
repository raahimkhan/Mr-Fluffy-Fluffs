import 'package:flutter/material.dart';
import 'package:fluffs/cart_1.dart';
import 'package:fluffs/extra.dart';
import 'package:fluffs/profile.dart';
import 'package:fluffs/sideBar.dart';
import 'package:fluffs/Data/addons.dart';
import 'package:fluffs/Data/temp_1.dart';
import 'package:fluffs/menu2.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';
import 'dart:async';
import 'dart:collection';
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;

List menuS;
List menu = menuS;

String url = 'http://mr-fluffy-fluffs.herokuapp.com/api/common/menu';

Future<dynamic> fetchMenu() async {
  Map<String, String> headers = new HashMap();
  headers.putIfAbsent('Accept', () => 'application/json');

  http.Response response = await http.get(
    url,
    headers: headers,
  );

  dynamic resp = jsonDecode(response.body) ;

  menuS =  resp as List ; // see below comments

  return resp ;
}

var toppings_url = 'http://mr-fluffy-fluffs.herokuapp.com/api/common/toppings' ;
Future <void> fetchToppings() async {
  var response = await Requests.get(
    toppings_url,
  );
  response.raiseForStatus();

  dynamic j = response.json();

  addons = j as List ;
}

List<String> myImg = ["assets/fluffyPancake.jpg", "assets/nutellaPancake.jpg", "assets/chocchipPancake.jpg", "assets/ww.jpg"];


class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

TextEditingController emailController = new TextEditingController();

class _MenuState extends State<Menu> {
  final GlobalKey<ScaffoldState> _menuKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    fetchToppings() ;
    return Scaffold(
      backgroundColor: Colors.white,
      key: _menuKey,
      drawerEdgeDragWidth: 0,
      drawer: SideBar(),
      body: Container(
        child: new FutureBuilder <dynamic> (
          future: fetchMenu(), // this future builder will determine whether guest is logged in or a registered user
          builder: (BuildContext context, AsyncSnapshot <dynamic> feedState) {
            if (feedState.hasData) {
              // This means future has been completed and we can use the data received to build our widgets
            }

            else {
              // This will run until future has not been completed
              return new Center(child: new CircularProgressIndicator());
            }

            return  ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => Cart(),
                        ),
                        );
                      },
                      icon: Icon(Icons.shopping_cart),
                      color: Colors.red[200],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: FlatButton(
                        onPressed: () {
                          _menuKey.currentState.openDrawer();
                        },
                        child: Text(
                          "Sort By",
                          style: TextStyle(
                            color: Colors.red[200],
                            fontSize: blockWidth * 4,
                            fontFamily: 'NunitoSans-Regular',
                          ),
                        ),
                      ),
                    ),
                    Flexible(
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
                            hintText: "Search Menu",
                            suffixIcon: IconButton(
                              onPressed: (){
                                List temp = menuS;
                                String name = emailController.text;

                                if (name.isEmpty){
                                  menu = menuS;
                                }
                                else {
                                  List<Map> temp2 = [];
                                  for (Map i in menu) {
                                    for (int j = 0; j < i['Name'].length; j++) {
                                      if(j+name.length+1>i['Name'].length){
                                        break;
                                      }
                                      if (name.toLowerCase() == i['Name']
                                          .substring(j, j + name.length)
                                          .toLowerCase()) {
                                        temp2.add(i);
                                        break;
                                      }
                                    }
                                  }
                                }
                              },
                              icon: Icon(Icons.search),
                            ),
                          ),
                          onSubmitted: (String name){
                            setState((){
                              List temp = menu;
                              if (name.isEmpty){
                                menu = menuS;
                              }
                              else {
                                List<Map> temp2 = [];
                                for (Map i in temp) {
                                  for (int j = 0; j < i['Name'].length; j++) {
                                    if(j+name.length+1>i['Name'].length){
                                      break;
                                    }
                                    if (name.toLowerCase() == i['Name']
                                        .substring(j, j + name.length)
                                        .toLowerCase()) {
                                      temp2.add(i);
                                      break;
                                    }
                                  }
                                }
                                menu = temp2;
                              }
                            });
                          }
                      ),
                    ),
                  ],
                ),
                HelperMenu(),
              ],
            );

          }
        ) ,

      ),
    );
  }
}



class HelperMenu extends StatefulWidget {

  @override
  _HelperMenuState createState() => _HelperMenuState();
}

class _HelperMenuState extends State<HelperMenu> {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return new Material(
      child:
      Container(
              // From the Left and Right of Container + A bit from Bottom
              padding: EdgeInsets.fromLTRB(blockWidth* 1.5, 0, blockHeight * 2, blockWidth * 2),
              child: Column (
                children: <Widget>[
                  SizedBox(height: blockWidth * 1.4),

                  // A ListView builder allows access to the List file containing the data in an easy and efficient manner
                  // This Data is then sent to another helper file which places all the components of the Menu in place.

                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: menu == null ? 0 :menu.length,
                    itemBuilder: (BuildContext context, int index) {

                      String a = menu[index]['Path'];
                      String b = '';
                      for(int i = 0; i<a.length; i++)
                      {
                        if(a[i]==' ')
                        {
                          b = b + '%20';
                        }
                        else {
                          b = b + a[i];
                        }
                      }
                      return SettingMenuCards(
                        img: b,
                        name: menu[index]['Name'],
                        subtitle: menu[index]['Description'],
                        price: menu[index]['Price'],
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

class SettingMenuCards extends StatelessWidget {
  final String name;
   String img;
  final String subtitle;
  final int price;

  SettingMenuCards({Key key, this.img, this.name, this.subtitle, this.price}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return Container(
      // For Image Padding
      padding: EdgeInsets.fromLTRB(0, blockHeight * 0.5, 0, blockHeight * 0.5),
      child: InkWell(
        onTap: (){
            // print("Hello Mama");
          Navigator.push(
            context,MaterialPageRoute(
              builder: (context) => MenuTwo(img: img, name: name, subtitle: subtitle, price:  price),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Padding(
              // For Text Padding
              padding: EdgeInsets.only(left: 0.0, right: blockWidth * 1.5),
              child: Container(
                height: blockWidth * 40,
                width: blockWidth * 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(blockWidth * 2),
                  child: Image.network(
                    img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Flexible(
              child:
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                   fontSize: blockWidth * 4,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[400],
                    fontFamily: 'NunitoSansSemiBold',
                  ),
                ),
                SizedBox(height: blockHeight * 1),
                Wrap(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Text(
                      subtitle,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: blockWidth * 3,
                        fontWeight: FontWeight.w300,
                        color: Colors.brown[400],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: blockHeight * 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                       padding: EdgeInsets.only(right: blockWidth * 2),
                       child: Text(
                       "Rs $price",
                       overflow: TextOverflow.ellipsis,
                       style: TextStyle(
                         fontSize: blockWidth * 4,
                         fontWeight: FontWeight.bold,
                         color: Colors.brown[400],
                       ),
                     ),
                   ),
                  ],
                ),
              ],
            ),
           ),
          ],
        ),
      ),
    );
  }
}