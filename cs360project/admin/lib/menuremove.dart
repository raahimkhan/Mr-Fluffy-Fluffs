import 'package:flutter/material.dart';
import 'package:admin/Data/menuItems.dart';
import 'package:admin/Data/temp_1.dart';

class MenuRemove extends StatefulWidget {
  @override
  _MenuRemoveState createState() => _MenuRemoveState();
}

TextEditingController emailController = new TextEditingController();

class _MenuRemoveState extends State<MenuRemove> {
  
  @override
  Widget build(BuildContext context) {

    // Variables for adjusting Screen width and Height according to different sizes

    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return Scaffold(
      // A ListView was used in this case instead of a column because we wanted this screen to scroll and this can't be done by using Columns
      body: Container(
        child: ListView(
          children: <Widget>[

            // Rows were used here to correctly position the icons and the search bars

            Padding(
              padding: EdgeInsets.only(top: blockHeight * 2),
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
                      hintText: "Search Items",
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
                          temp = temp2;
                        }
                      });
                    }
                  ),
                ),
              ),
            ),
            HelperMenuRemove(),
          ],
        ),
      ),
    );
  }
}


// A special helper class created for adding the menu items

class HelperMenuRemove extends StatefulWidget {

  @override
  _HelperMenuRemoveState createState() => _HelperMenuRemoveState();
}

class _HelperMenuRemoveState extends State<HelperMenuRemove> {

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
                Map menu = menuItems[index];
                return SettingMenuRemove(
                  name: menu['name'],
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

class SettingMenuRemove extends StatelessWidget {
  final String name;

  SettingMenuRemove({Key key, this.name}) :super(key: key);
 
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;

  // This helper file placed all the components of the menu
    return Material(
      child: Column(
        children: <Widget>[
          SizedBox(height: blockWidth * 3),
          lines(blockWidth),
          SizedBox(height: blockWidth * 1),
          Padding(
            padding: EdgeInsets.only(left: blockWidth * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: blockWidth * 3.8,
                      color: Color(0xffbb5e1e),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: blockWidth * 2),
                  child: RaisedButton(
                    onPressed: () {
                      print("Remove");
                    },
                    child: Text(
                      "Remove",
                      style:  TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(blockWidth * 4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: blockWidth * 1),
        ],
      ),
    );
  }
}

Widget lines(wTH) {
  return Divider(
    thickness: 0.4,
    color: Colors.black,
    indent: wTH * 3,
    endIndent: wTH * 5,
  );
}
