import 'package:flutter/material.dart';
import 'package:admin/Data/menuItems.dart';
import 'package:admin/menuadd.dart';
import 'package:admin/menuremove.dart';
import 'dart:async';
import 'dart:collection';
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;
import 'package:http/http.dart' as http ;
import 'dart:convert';

List temp ; // Used in search bar as a temp variable. Equated to menuList

class MenuManage extends StatefulWidget {
  @override
  _MenuManageState createState() => _MenuManageState();
}

TextEditingController emailController = new TextEditingController();

class _MenuManageState extends State<MenuManage> {
  
  @override
  Widget build(BuildContext context) {

    // Variables for adjusting Screen width and Height according to different sizes

    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return Scaffold(
      backgroundColor: Colors.white,

      // A ListView was used in this case instead of a column because we wanted this screen to scroll and this can't be done by using Columns

      body: Container(
          child: new FutureBuilder <dynamic> (

          future: fetchMenu(),
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

                // Rows were used here to correctly position the icons and the search bars

                Padding(
                  padding: EdgeInsets.only(top: blockWidth * 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,MaterialPageRoute(
                            builder: (context) => MenuRemove(),
                          ),
                          );
                        },
                        icon: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(blockWidth * 2),
                              color: Colors.red,
                              border: Border.all(width: blockWidth * 0.5, color: Color(0xffbb5e1e))),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: blockWidth * 8,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,MaterialPageRoute(
                            builder: (context) => MenuAdd(),
                          ),
                          );
                        },
                        icon:Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(blockWidth * 2),
                              color: Colors.brown[400],
                              border: Border.all(width: blockWidth * 0.5, color: Colors.black)),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: blockWidth * 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: blockHeight * 3),
                Container(
                  child: Align(
                    child: SizedBox(
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
                            hintText: "Search Menu",
                            suffixIcon: IconButton(
                              onPressed: (){
                                String name = emailController.text;
                                if (name.isEmpty){
                                  temp = menuItems;
                                }
                                else {
                                  List<Map> temp2 = [];
                                  for (Map i in temp) {
                                    for (int j = 0; j < i['name'].length; j++) {
                                      if(j+name.length+1>i['name'].length){
                                        break;
                                      }
                                      if (name.toLowerCase() == i['name']
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
                              if (name.isEmpty){
                                menuItems = temp;
                              }
                              else {
                                List<Map> temp2 = [];
                                for (Map i in menuItems) {
                                  for (int j = 0; j < i['name'].length; j++) {
                                    if(j+name.length+1>i['name'].length){
                                      break;
                                    }
                                    if (name.toLowerCase() == i['name']
                                        .substring(j, j + name.length)
                                        .toLowerCase()) {
                                      temp2.add(i);
                                      break;
                                    }
                                  }
                                }
                                menuItems = temp2;
                              }
                            });
                          }
                      ),
                    ),
                  ),
                ),

                HelperMenuManage(),
              ],
            );
          }
          ),
      ),
    );
  }
}


// A special helper class created for adding the menu items

class HelperMenuManage extends StatefulWidget {

  @override
  _HelperMenuManageState createState() => _HelperMenuManageState();
}

class _HelperMenuManageState extends State<HelperMenuManage> {

  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return Material(
      child: Container(
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
              itemCount: menuItems == null ? 0 :menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                String a = menuItems[index]['Path'];
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
                return SettingMenuManageCards(
                  img: b,
                  name: menuItems[index]['Name'],
                  subtitle: menuItems[index]['Description'],
                  price: menuItems[index]['Price'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


// This helper file placed all the components of the menu

class SettingMenuManageCards extends StatelessWidget {
  final String name;
  final String img;
  final String subtitle;
  final int price;

  SettingMenuManageCards({Key key, this.img, this.name, this.subtitle, this.price}) :super(key: key);
 
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;

  // This helper file placed all the components of the menu
    return Container(
      // For Image Padding
      padding: EdgeInsets.fromLTRB(0, blockHeight * 0.5, 0, blockHeight * 0.5),
      child: InkWell(
        onTap: (){
          // Navigator.push(
          //   context,MaterialPageRoute(
          //     builder: (context) => MenuManageTwo(img: img, name: name, subtitle: subtitle, price:  price),
          //   ),
          // );
        },

        // For adjusting the images in place
        
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

            // The Flexible Widget allowed the components to be placed according to the alignments mentioned. 
            // Wrap was used for the Description Section so the text would not overflow

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