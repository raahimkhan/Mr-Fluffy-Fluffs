import 'package:flutter/material.dart';

class Receipt extends StatefulWidget {

  final date, pancakes, subtotal, delfee, total;

  Receipt({Key key, this.date, this.pancakes, this.subtotal, this.delfee, this.total}) : super(key: key);

  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  
  @override
  Widget build(BuildContext context) {

    // Variables for adjusting Screen width and Height according to different sizes

    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
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
      ),

      // A ListView was used in this case instead of a column because we wanted this screen to scroll and this can't be done by using Columns

      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[

            // Rows were used here to correctly position the icons and the search bars

            SizedBox(
              height: blockWidth * 42,
              child: Card(
                color: Colors.orange[200],
                child: Align(
                  child: SizedBox(
                    width: blockWidth * 50,
                    height: blockWidth * 45,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: blockWidth * 5),
                      child: Image(
                        image: AssetImage(
                          'assets/pancake1.png'
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: blockWidth * 2),
            SizedBox(
              height: blockWidth * 18,
              child: Card(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: blockWidth * 5,
                        fontWeight: FontWeight.bold, 
                      ),
                    ),
                    Text(
                      widget.date,
                      style: TextStyle(
                        fontSize: blockWidth * 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: widget.pancakes == null ? 0 :widget.pancakes.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map elem = widget.pancakes[index];
                      return ReceiptMenu(
                        name: elem['Name'],
                        quan: elem['Quantity'],
                        price: elem['Price'],
                      );
                    },
                ),
              ],
            ),
            SizedBox(height: blockWidth * 2),
            PriceMenu(subTotal: widget.subtotal, delPrice: widget.delfee, total: widget.total),
          ],
        ),
      ),
    );
  }
}

class ReceiptMenu extends StatelessWidget {

  final name, quan, price;

  ReceiptMenu({Key key, this.name, this.quan, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return SizedBox(
      height: blockWidth * 18,
      child: Card(
        color: Colors.orange[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Flexible (
                  child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: blockWidth * 4,
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                ),
                ),             
              ],
            ),
            Column(
              children: <Widget>[
                Flexible(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                    "$quan",
                    style: TextStyle(
                      fontSize: blockWidth * 4,
                    ),
                  ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Flexible(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                    "RS $price",
                    style: TextStyle(
                      fontSize: blockWidth * 5,
                    ),
                  ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PriceMenu extends StatefulWidget {

  final subTotal, delPrice, total;


  PriceMenu({Key key, this.subTotal, this.delPrice, this.total}) : super(key:key);

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
                      fontSize: blockWidth * 4.5,
                      color: Color(0xffbb5e1e),
                    ),
                   ),
                  SizedBox(height: blockHeight * 0.5),
                  Text(
                    "Delivery Fee",
                    style: TextStyle(
                      fontSize: blockWidth * 4.5,
                      color: Color(0xffbb5e1e),
                    ),
                   ),
                  SizedBox(height: blockHeight * 0.5),
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: blockWidth * 4.5,
                      color: Color(0xffbb5e1e),
                    ),
                   ),
                ],
              ),
              SizedBox(width: blockWidth * 1.4),
              Padding(
                padding: EdgeInsets.only(right: blockWidth * 4),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                      Text(
                        "RS ${widget.subTotal}",
                        style: TextStyle(
                          fontSize: blockWidth * 4.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffbb5e1e),
                        ),
                      ),
                      SizedBox(height: blockHeight * 0.5),
                      Text(
                        "RS ${widget.delPrice}",
                        style: TextStyle(
                          fontSize: blockWidth * 4.5,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffbb5e1e),
                        ),
                      ),
                      SizedBox(height: blockHeight * 0.5),
                      Text(
                        "RS ${widget.total}",
                        style: TextStyle(
                          fontSize: blockWidth * 4.5,
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