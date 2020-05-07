import 'dart:async';
import 'package:fluffs/Data/details.dart';
import 'package:flutter/material.dart';
import 'package:fluffs/profile.dart';
import 'package:fluffs/extra.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';
import 'dart:async';
import 'dart:collection';

TextEditingController emailController_1 = new TextEditingController();
TextEditingController emailController_2 = new TextEditingController();
TextEditingController emailController_3 = new TextEditingController();
Widget lines(wTH) {
  return Divider(
    thickness: 0.4,
    color: Colors.black,
    indent: wTH * 0.04,
    endIndent: wTH * 0.05,
  );
}


class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  int phone = 03214559559;
  String address = "134 DHA Lahore";
  double delPrice = 40;
  String payment = 'Cash on Delivery';


  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: blockHeight * 2.8),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => Profile(),
                      ),
                    );
                  },
                  icon: Icon(Icons.person, color: Colors.red[200]),
                ),
              ],
            ),
          ),
          SizedBox(height: blockHeight * 2),
          Padding(
            padding: EdgeInsets.only(left: blockWidth * 2.5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "My Cart (${bloc.allItems[bloc.allItems.length-1]['quan'] + bloc.allItems[bloc.allItems.length-1]['number']})",
                style: TextStyle(
                  color: Color(0xffbb5e1e),
                  fontSize: blockWidth * 5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: blockHeight * 0.5),
          lines(blockWidth),
              bloc.allItems.length == 0  ? Material(child: Container(),) : ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: bloc.allItems.length,
              itemBuilder: (BuildContext context, int index) {
                Map elem = bloc.allItems[index];
                return CartMenu(
                  index: elem,
                  name: elem['name'],
                  price: elem['price']*elem['number'],
                  img: elem['img'],
                  number: elem['number'],
                );
              },
          ),
          lines(blockWidth),
          PriceMenu(subTotal: bloc.calculate() , delPrice: delPrice),
          lines(blockWidth),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: details.length,
            itemBuilder: (BuildContext context, int index) {
              Map elem = details[index];
              return UserMenu(
                  index : elem,
                  phone : elem['phone'],
                  address: elem['address'],
                  payment: elem['payment'],
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: OrderButton(),
    );
  }
}

class CartMenu extends StatefulWidget {

  final name, img;
  int price, number, quan;
  var index;


  // final cartStreamController = StreamController.broadcast();

  CartMenu({Key key, this.index, this.name, this.price, this.img, this.number, this.quan}): super(key:key);

  @override

  _CartMenuState createState() => _CartMenuState();

}

class _CartMenuState extends State<CartMenu> {

  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    int n = widget.number;
     if(bloc.allItems.length ==0) {
       print('Empty');
       return Container();
     }

    else {
      return Container(
        padding: EdgeInsets.fromLTRB(
            blockWidth * 2, blockHeight * 1.5, 0, blockWidth * 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  // For Text Padding
                  padding: EdgeInsets.only(left: 0.0, right: blockWidth * 1.5),
                  child: Container(
                    height: blockWidth * 12,
                    width: blockWidth * 12,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(blockWidth * 2),
                      child: Image.network(
                        widget.img,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: blockWidth * 3.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffbb5e1e),
                    fontFamily: 'NunitoSansSemiBold',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: blockHeight * 2.8,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          int i = bloc.allItems.indexOf(widget.index);
                          bloc.allItems[i]['number'] =
                              bloc.allItems[i]['number'] - 1;
                          bloc.allItems[i]['price'] =
                              bloc.allItems[i]['price'] -
                                  bloc.allItems[i]['original'];
                          quan--;
                          if (bloc.allItems[i]['number'] == 0) {
                            bloc.allItems.remove(widget.index);
                          }

                          Navigator.push(
                              context, MaterialPageRoute(
                            builder: (BuildContext context) => Cart(),
                          ));
//                         int p = widget.price;
//                         int n = widget.number;
//                         int x = (p~/(n-1));
//                         widget.price = p + x;
//
//                         Navigator.push(
//                             context, MaterialPageRoute(
//                           builder: (BuildContext context) => Cart(),
//                        ));
                        });
                      },
                      child: Icon(Icons.remove, color: Color(0xffbb5e1e),
                          size: blockWidth * 3),
                      backgroundColor: Colors.white,
                      heroTag: null,
                    ),
                  ),
                ),
                SizedBox(width: blockWidth * 0.05),
                Text('${widget.number}',
                    style: TextStyle(fontSize: blockWidth * 4)),
                SizedBox(width: blockWidth * 0.05),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: blockHeight * 2.8,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          int i = bloc.allItems.indexOf(widget.index);
                          bloc.allItems[i]['number'] =
                              bloc.allItems[i]['number'] + 1;
                          bloc.allItems[i]['price'] =
                              bloc.allItems[i]['price'] +
                                  bloc.allItems[i]['original'];
                          quan++;

                          Navigator.push(
                              context, MaterialPageRoute(
                            builder: (BuildContext context) => Cart(),
                          ));
//                         int p = widget.price;
//                         int n = widget.number;
//                         int x = (p~/(n-1));
//                         widget.price = p + x;
//
//                         Navigator.push(
//                             context, MaterialPageRoute(
//                           builder: (BuildContext context) => Cart(),
//                        ));
                        });
                      },
                      child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: blockWidth * 3
                      ),
                      backgroundColor: Color(0xffbb5e1e),
                      heroTag: null,
                    ),
                  ),
                ),
              ],
            ),
            // Text("${widget.price}", style: TextStyle(fontSize: blockWidth * 4, color: Color(0xffbb5e1e), fontWeight: FontWeight.bold)),
          ],
        ),

      );
    }
  }
}

class PriceMenu extends StatefulWidget {

  final subTotal, delPrice,number;


  PriceMenu({Key key, this.subTotal, this.delPrice, this.number}) : super(key:key);

  @override
  _PriceMenuState createState() => _PriceMenuState();
}

class _PriceMenuState extends State<PriceMenu> {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget> [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Subtotal",
                    style: TextStyle(
                      fontSize: blockWidth * 3,
                      color: Color(0xffbb5e1e),
                    ),
                   ),
                  SizedBox(height: blockHeight * 0.5),
                  Text(
                    "Delivery Fee",
                    style: TextStyle(
                      fontSize: blockWidth * 3,
                      color: Color(0xffbb5e1e),
                    ),
                   ),
                  SizedBox(height: blockHeight * 0.5),
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: blockWidth * 3,
                      color: Color(0xffbb5e1e),
                    ),
                   ),
                ],
              ),
              SizedBox(width: blockWidth * 1.4),
              Padding(
                padding: EdgeInsets.only(right: blockWidth * 2),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                      Text(
                        "${widget.subTotal}",
                        style: TextStyle(
                          fontSize: blockWidth * 3,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffbb5e1e),
                        ),
                      ),
                      SizedBox(height: blockHeight * 0.5),
                      Text(
                        "${widget.delPrice}",
                        style: TextStyle(
                          fontSize: blockWidth * 3,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffbb5e1e),
                        ),
                      ),
                      SizedBox(height: blockHeight * 0.5),
                      Text(
                        "${widget.subTotal + widget.delPrice}",
                        style: TextStyle(
                          fontSize: blockWidth * 3,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffbb5e1e),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserMenu extends StatefulWidget {
  
  var phone, address, payment, index;

  UserMenu({Key key, this.phone, this.address, this.payment, this.index}) : super(key:key);
  
  @override
  _UserMenuState createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: <Widget> [
              Container(

             child:Padding(
               padding: EdgeInsets.only(left: blockWidth* 3),
               child:
             Text('Phone',
                style: TextStyle(
                  fontSize: blockWidth * 4,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffbb5e1e),
                  fontFamily: 'NunitoSansSemiBold',
                ),),
             )
              ),

    Flexible(
      child: Align(
        alignment: Alignment.topRight,
              child:  Container(
                 width: blockWidth*37,
                  child: TextField(
                    controller: emailController_1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: '${details[0]['phone']}',
                      border: InputBorder.none,
                  ),
                      onSubmitted: (String name){
                      details[0]['phone'] = name;

                      }
                ),


               ),
),
    )

            ],
          ),
          lines(blockWidth),
          Row(
            children: <Widget> [
              Padding(
                padding: EdgeInsets.only(left: blockWidth* 3),
                child:

              Text('Destination Address',
                style: TextStyle(
                  fontSize: blockWidth * 4,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffbb5e1e),
                  fontFamily: 'NunitoSansSemiBold',
                ),),
              ),

              Flexible(
          child: Align(
            alignment: Alignment.topRight,
                child: Container(

                  width: blockWidth * 37,

                child:
                TextField(
                  controller: emailController_2,
                  keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: '${details[0]['address']}',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (String name){
                      details[0]['address'] = name;

                    }
                ),

              ),
                )
              ),

            ],
         ),
          lines(blockWidth),
          Row(
            children: <Widget> [
              Padding(
                padding: EdgeInsets.only(left: blockWidth* 3),
                child:
              Text('Payment Method',
                style: TextStyle(
                  fontSize: blockWidth * 4.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffbb5e1e),
                  fontFamily: 'NunitoSansSemiBold',
                ),),
              ),
              Flexible(
                child: Align(
                  alignment : Alignment.topRight,
                  child: Container(
                  width: blockWidth * 37,
                child:
                TextField(
                  controller: emailController_3,
                  keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: '${details[0]['payment']}',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (String name){
                      details[0]['payment'] = name;

                    }
                ),

              ),
              ),
              )

            ],
          ),
          lines(blockWidth),
        ],
      ),
    );
  }
}


class UserMenuTwo extends StatefulWidget {
  
  @override
  _UserMenuTwoState createState() => _UserMenuTwoState();
}

class _UserMenuTwoState extends State<UserMenuTwo> {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          Row(
            children: <Widget> [
              Padding(
                padding: EdgeInsets.fromLTRB(blockWidth * 2,0,0,0),
                child: Text(
                  "Payment",
                  style: TextStyle(
                    fontSize: blockWidth * 3,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffbb5e1e),
                  ),
                ),
              ),
            ],
         ),
          Row(
            children: <Widget> [
              Padding(
                padding: EdgeInsets.fromLTRB(0,0,blockWidth * 5,0),
                child: Text(
                  "Cash on Delivery",
                  style: TextStyle(
                    fontSize: blockWidth * 2,
                    color: Color(0xffbb5e1e),
                  ),
                ),
              ),
            ],
         ),
          
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;

    return Card(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Padding(
            padding: EdgeInsets.fromLTRB(0, blockHeight * 0.8, 0, blockHeight * 1.2),
            child: SizedBox(
              width: blockWidth * 40,
              height: blockHeight *6,
              child: RaisedButton(
                onPressed: () async {

                  Map Final = {};
                  Map cart = {};
                  List pancake = [];
                  Map c = {};
                  cart['Subtotal'] = bloc.calculate();
                  cart['Deliveryfee'] = 40;
                  cart['MobileNo'] = details[0]['phone'];
                  cart['Address'] = details[0]['address'];
                  for (Map i in bloc.allItems){
                    c = {'Quantity': i['number'], 'Name': i['name'], 'Price': i['price'], 'Addons': i['toppings']};
                    pancake.add(c);
                    c = {};
                  }
                  cart['Pancakes'] = pancake;
                  cart['Username'] = cartUsername ;
                  Final['cart'] = cart;
                  String jsonStr = jsonEncode(Final);

                  dynamic resp ;

                  await http.put(Uri.encodeFull('http://mr-fluffy-fluffs.herokuapp.com/api/user/cart'), body: jsonStr , headers: { "Content-Type" : "application/json"}).then((result) {
                    resp = jsonDecode(result.body) ;
                  });

                  String message ;

                  if (resp['msg'] == 'MobileNo not reachable') {
                    message = 'Please enter correct Mobile Number.' ;
                  }

                  else {
                    message = 'Your Order has been placed successfully, you will recieve an SMS confirming this.' ;
                  }

                  AlertDialog alert = AlertDialog(
                    title: Text(message),
                    actions: [
                      RaisedButton(
                        onPressed: () {
                          if (message == 'Your Order has been placed successfully, you will recieve an SMS confirming this.') {
                            Navigator.of(context).pushReplacementNamed('/home_screen') ;
                            bloc.allItems = [];
                          }

                          else {
                            Navigator.of(context).pop() ;
                            Navigator.of(context).pushReplacementNamed('/cart_1') ;
                          }
                        }, child: Text('Ok'),
                      ),
                    ],
                  ) ;

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert ;
                    },
                  ) ;

                },
                textColor: Colors.white,
                color: Color(0xffbb5e1e),
                child: Center(
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: blockWidth * 3,
                      fontFamily: 'NunitoSansSemiBold',
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(blockWidth * 6)
                ),
              ),
            ),
          ),  
        ],
      ),      
    );
  }
}

