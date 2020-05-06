import 'package:flutter/material.dart';
import 'package:fluffs/Data/temp_1.dart';
import 'package:fluffs/menu.dart';


class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return Container(
        width: blockWidth * 65,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Align(
                  alignment: Alignment.center,
                ),
              ),
              ListTile(
                title: Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.brown[600],
                    fontSize: blockWidth * 5,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign:TextAlign.center,
                ),
              ),
              ListTile(
                title: Text(
                  'A-Z',
                  style: TextStyle(
                    color: Colors.brown[400],
                    fontSize: blockWidth * 3.5,
                  ),
                  textAlign:TextAlign.center,
                ),
                onTap: (){

                    menu.sort((a, b) => a['Name'].compareTo(b['Name']));
                    Navigator.push(
                        context, MaterialPageRoute(
                      builder: (BuildContext context) => Menu(),
                    ));


                },



              ),
              ListTile(
                title: Text(
                  'Z-A',
                  style: TextStyle(
                    color: Colors.brown[400],
                    fontSize: blockWidth * 3.5,
                  ),
                  textAlign:TextAlign.center,
                ),
                onTap: (){
                  menu.sort((b,a)=>a['Name'].compareTo(b['Name']));
                  Navigator.push(
                      context, MaterialPageRoute(
                    builder: (BuildContext context) => Menu(),
                  ));
                },
              ),
              ListTile(
                title: Text(
                  'Price',
                  style: TextStyle(
                    color: Colors.brown[600],
                    fontSize: blockWidth * 5,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign:TextAlign.center,
                ),
              ),
              ListTile(
                title: Text(
                  'Low-High',
                  style: TextStyle(
                    color: Colors.brown[400],
                    fontSize: blockWidth * 3.5,
                  ),
                  textAlign:TextAlign.center,
                ),
                onTap: (){
                  menu.sort((a,b)=>a['Price'].compareTo(b['Price']));

                },
              ),
              ListTile(
                title: Text(
                  'High-Low',
                  style: TextStyle(
                    color: Colors.brown[400],
                    fontSize: blockWidth * 3.5,
                  ),
                  textAlign:TextAlign.center,
                ),
                onTap: (){
                  menu.sort((b,a)=>a['Price'].compareTo(b['Price']));
                  Navigator.push(
                      context, MaterialPageRoute(
                    builder: (BuildContext context) => Menu(),
                  ));


                },
              ),
            ],
          ),       
      ),
    );
  }
}
