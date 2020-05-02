import 'package:flutter/material.dart';
import 'package:fluffs/cart_1.dart';
import 'package:fluffs/extra.dart';

List orderList = [
  {
    "id" : "ABCXYZ",
    "date" : "Sep 24",
    "price": "RS 240",
    "state": "Pending",
  },
  {
    "id" : "RXDZIU",
    "date" : "Sep 18",
    "price": "RS 100",
    "state": "Completed",
  },
  {
    "id" : "CDXALT",
    "date" : "Aug 18",
    "price": "RS 120",
    "state": "Completed",
  },
  {
    "id" : "ARQSFG",
    "date" : "Jul 9",
    "price": "RS 340",
    "state": "Completed",
  },
];

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

TextEditingController emailController = new TextEditingController();

class _OrderState extends State<Order> {
  
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
              itemCount: orderList == null ? 0 :orderList.length,
              itemBuilder: (BuildContext context, int index) {
                Map elem = orderList[index];
                return OrderMenuSetup(
                  id: elem['id'],
                  date: elem['date'],
                  price: elem['price'],
                  state: elem['state'],
                );
              },
          ),
        ],
      ),
    );
  }
}

class OrderMenuSetup extends StatelessWidget {

  final id, date, price, state;

  OrderMenuSetup({Key key, this.id, this.date, this.price, this.state}) : super(key: key);

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
                date,
                style: TextStyle(
                  fontSize: blockWidth * 3.5,
                  color: Color(0xffbb5e1e),
                ),
              ),
              Text(
                price,
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
              print("Details");
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