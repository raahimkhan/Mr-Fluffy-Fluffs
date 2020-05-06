import 'package:flutter/material.dart';
import 'package:fluffs/cart_1.dart';
import 'package:fluffs/extra.dart';
import 'package:fluffs/receipt.dart';
import 'dart:async';
import 'dart:collection';
import 'package:requests/requests.dart' ;
import 'package:shared_preferences/shared_preferences.dart' ;

List data ;

var history_url = 'http://mr-fluffy-fluffs.herokuapp.com/api/user/cart/history' ;
Future <void> chech_history() async {
  var response = await Requests.get(
    history_url,
  );
  response.raiseForStatus();

  dynamic j = response.json() ;

  data = j['data'] as List ;
}

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

TextEditingController emailController = new TextEditingController();

class _OrderState extends State<Order> {
  
  @override
  Widget build(BuildContext context) {

    chech_history() ;

    // Variables for adjusting Screen width and Height according to different sizes

    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[

            // Rows were used here to correctly position the icons and the search bars

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
            ),
            SizedBox(height: blockHeight * 2),
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
                      hintText: "Search Purchases",
                      suffixIcon: IconButton(
                        onPressed: (){
                        },
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: blockHeight * 2),
            OrderMenu(),
          ],
        ),
      ),
    );
  }
}

class OrderMenu extends StatefulWidget {
  @override
  _OrderMenuState createState() => _OrderMenuState();
}

class _OrderMenuState extends State<OrderMenu> {

  TextEditingController emailController = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: data == null ? 0 :data.length,
              itemBuilder: (BuildContext context, int index) {
                Map elem = data[index];
                return OrderMenuSetup(
                  id: elem['Tracking_ID'],
                  date: elem['Date'],
                  price: elem['Total'],
                  state: elem['Status'],
                  pancakes: elem['Pancakes'],
                  subtotal: elem['Subtotal'],
                  delfee: elem['Deliveryfee'],
                );
              },
          ),
        ],
      ),
    );
  }
}

class OrderMenuSetup extends StatelessWidget {

  final id, price, state, pancakes, subtotal, delfee;
  final String date; 

  OrderMenuSetup({Key key, this.id, this.date, this.price, this.state, this.pancakes, this.subtotal, this.delfee}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Variables for adjusting Screen width and Height according to different sizes

    var wTH = MediaQuery.of(context).size.width;
    // var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    // var blockHeight = hTH / 100;
    return Card(
      // padding: EdgeInsets.fromLTRB(0, blockHeight * 0.5, 0, blockHeight * 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "$id",
            style: TextStyle(
              fontSize: blockWidth * 3.5,
              color: Color(0xffbb5e1e),
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                displayDate(date),
                style: TextStyle(
                  fontSize: blockWidth * 3.5,
                  color: Color(0xffbb5e1e),
                ),
              ),
              Text(
                "RS $price",
                style: TextStyle(
                  fontSize: blockWidth * 3.5,
                  color: Color(0xffbb5e1e),
                ),
              ),
            ],
          ),
          Text(
            state,
            style: TextStyle(
              fontSize: blockWidth * 3.5,
              color: Color(0xffbb5e1e),
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => Receipt(date:date, pancakes:pancakes, subtotal:subtotal, delfee:delfee, total:price),
                ),
              );
            },
            child: Text(
              "Details",
              style:  TextStyle(
                color: Colors.white,
              ),
            ),
            color: Color(0xffbb5e1e),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(blockWidth * 4),
            ),
          ),
        ],
      ),
    );
  }
}

String displayDate(date) {
  var month = date.substring(5,7);
  var day = date.substring(8,10);
  var myInt = int.parse(month);
  String mon =  getMonth(myInt);
  String check = mon + " " + day;
  return check;
}

String getMonth(number) {
  List monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"];
  return monthNames[number - 1]; 
}