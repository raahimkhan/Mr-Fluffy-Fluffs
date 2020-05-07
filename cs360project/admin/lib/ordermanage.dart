import 'package:flutter/material.dart';
import 'package:admin/receipt.dart';
import 'package:admin/Data/orderUtility.dart' ;

List temp = ordersPending ;
List temp1 = ordersDone ;

class OrderManage extends StatefulWidget {
  @override
  _OrderManageState createState() => _OrderManageState();
}

TextEditingController emailController = new TextEditingController();
TextEditingController emailController_2 = new TextEditingController();

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
                            onSubmitted: (String name){
                              setState((){
                                name = emailController.text;

                                if (name.isEmpty){
                                  temp = ordersPending;
                                }
                                else {
                                  List<Map> temp2 = [];
                                  for (Map i in temp) {
                                    for (int j = 0; j < i['Tracking_ID'].length; j++) {
                                      if(j+name.length+1>i['Tracking_ID'].length){
                                        break;
                                      }
                                      if (name.toLowerCase() == i['Tracking_ID']
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

                            },
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
                          controller: emailController_2,
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
                            onSubmitted: (String name){
                        setState((){
                          name = emailController_2.text;

                        if (name.isEmpty){
                        temp1 = ordersDone;
                        }
                        else {
                        List<Map> temp2 = [];
                        for (Map i in temp1) {
                        for (int j = 0; j < i['Tracking_ID'].length; j++) {
                        if(j+name.length+1>i['Tracking_ID'].length){
                        break;
                        }

                        if (name.toLowerCase() == i['Tracking_ID']
                            .substring(j, j + name.length)
                            .toLowerCase()  )   {

                        temp2.add(i);
                        break;
                        }
                        }
                        }
                        temp1 = temp2;
                        }
                        });
                        },
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
              itemCount: temp == null ? 0 :temp.length,
              itemBuilder: (BuildContext context, int index) {
                Map elem = temp[index];
                return OrderManageMenuSetup(
                  id: elem['Tracking_ID'],
                  date: elem['Date'],
                  price: elem['Total'],
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
              itemCount: temp1 == null ? 0 :temp1.length,
              itemBuilder: (BuildContext context, int index) {
                Map elem = temp1[index];

                  return OrderManageMenuTwoSetup(
                    id: elem['Tracking_ID'],
                    date: elem['Date'],
                    price: elem['Total'],
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

class OrderManageMenuSetup extends StatelessWidget {

  final id, price, state, pancakes, subtotal, delfee;
  final String date; 

  OrderManageMenuSetup({Key key, this.id, this.date, this.price, this.state, this.pancakes, this.subtotal, this.delfee}) : super(key: key);

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
                displayDate(date),
                style: TextStyle(
                  fontSize: blockWidth * 5,
                  color: Color(0xffbb5e1e),
                ),
              ),
              Text(
                "RS $price",
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
                onPressed: () async {
                  var body = { 'order': {'Status':  'Completed'} } ;
                    dynamic resp = await confirmOrder("$id",  body) ;

                  AlertDialog alert = AlertDialog(
                    title: Text('Order completed.'),
                    actions: [
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop() ;
                          Navigator.of(context).pushReplacementNamed('/home_screen') ;
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
                child: Text(
                  "Confirm",
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

  final id, price, state, pancakes, subtotal, delfee;
  final String date; 

  OrderManageMenuTwoSetup({Key key, this.id, this.date, this.price, this.state, this.pancakes, this.subtotal, this.delfee}) : super(key: key);

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
                displayDate(date),
                style: TextStyle(
                  fontSize: blockWidth * 4,
                  color: Color(0xffbb5e1e),
                ),
              ),
              Text(
                "RS $price",
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