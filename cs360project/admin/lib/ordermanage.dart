import 'package:flutter/material.dart';

List orderList = [
  {
    "id" : "ABCXYZ",
    "date" : "Sep 24",
    "price": "RS 240",
  },
  {
    "id" : "RXDZIU",
    "date" : "Sep 18",
    "price": "RS 100",
  },
  {
    "id" : "CDXALT",
    "date" : "Aug 18",
    "price": "RS 120",
  },
  {
    "id" : "ARQSFG",
    "date" : "Jul 9",
    "price": "RS 340",
  },
];

class OrderManage extends StatefulWidget {
  @override
  _OrderManageState createState() => _OrderManageState();
}

TextEditingController emailController = new TextEditingController();

class _OrderManageState extends State<OrderManage> {
  
  @override
  Widget build(BuildContext context) {

    // Variables for adjusting Screen width and Height according to different sizes

    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return Material(
      child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  Flexible(
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
                ],
                backgroundColor: Colors.white,
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        "Pending",
                        style: TextStyle(
                          color: Color(0xffbb5e1e),
                          fontSize: blockWidth * 5,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Completed",
                        style: TextStyle(
                          color: Color(0xffbb5e1e),
                          fontSize: blockWidth * 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),                
              body: TabBarView(
              children: <Widget>[
                ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
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
                              hintText: "Search Orders",
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
                    SizedBox(height: blockHeight * 3),
                    OrderManageMenu(),
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
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
                            hintText: "Search Orders",
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
                    SizedBox(height: blockHeight * 3),
                    OrderManageMenuTwo(),
                  ],
                ),
              ],
            ), 
            ),
          ),
    );
  }
}

class OrderManageMenu extends StatefulWidget {
  @override
  _OrderManageMenuState createState() => _OrderManageMenuState();
}

class _OrderManageMenuState extends State<OrderManageMenu> {
  
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
                return OrderManageMenuSetup(
                  id: elem['id'],
                  date: elem['date'],
                  price: elem['price'],
                );
              },
          ),
        ],
      ),
    );
  }
}

class OrderManageMenuTwo extends StatefulWidget {
  @override
  _OrderManageMenuTwoState createState() => _OrderManageMenuTwoState();
}

class _OrderManageMenuTwoState extends State<OrderManageMenuTwo> {
  
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
                return OrderManageMenuTwoSetup(
                  id: elem['id'],
                  date: elem['date'],
                  price: elem['price'],
                );
              },
          ),
        ],
      ),
    );
  }
}

class OrderManageMenuSetup extends StatelessWidget {

  final id, date, price;

  OrderManageMenuSetup({Key key, this.id, this.date, this.price}) : super(key: key);

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
              fontSize: blockWidth * 5,
              color: Color(0xffbb5e1e),
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                date,
                style: TextStyle(
                  fontSize: blockWidth * 5,
                  color: Color(0xffbb5e1e),
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: blockWidth * 5,
                  color: Color(0xffbb5e1e),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
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
              RaisedButton(
                onPressed: () {
                  print("Cancel");
                },
                child: Text(
                  "Cancel",
                  style:  TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(blockWidth * 4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderManageMenuTwoSetup extends StatelessWidget {

  final id, date, price;

  OrderManageMenuTwoSetup({Key key, this.id, this.date, this.price}) : super(key: key);

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
              fontSize: blockWidth * 4,
              color: Color(0xffbb5e1e),
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                date,
                style: TextStyle(
                  fontSize: blockWidth * 4,
                  color: Color(0xffbb5e1e),
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: blockWidth * 4,
                  color: Color(0xffbb5e1e),
                ),
              ),
            ],
          ),
          Center(
            child: RaisedButton(
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
          ),
        ],
      ),
    );
  }
}