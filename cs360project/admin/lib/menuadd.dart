import 'package:flutter/material.dart';

class MenuAdd extends StatelessWidget {

  final TextEditingController emailController = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    // Variables for adjusting Screen width and Height according to different sizes

    var wTH = MediaQuery.of(context).size.width;
    var hTH = MediaQuery.of(context).size.height;
    var blockWidth = wTH / 100;
    var blockHeight = hTH / 100;
    return Scaffold(
      // backgroundColor: Colors.white,

      body: Container(
        // height: blockHeight * 200,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[

            // Rows were used here to correctly position the icons and the search bars

            Padding(
              padding: EdgeInsets.only(top: blockHeight * 3),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                imageIcon(blockWidth, blockHeight),
              ],
            ),
            SizedBox(height: blockWidth * 5),
            Container(
              child: Align (
                child: SizedBox(
                  width: blockWidth * 80,
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.brown[200], 
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      hintText: "Title",
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: blockWidth * 5),
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
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      hintText: "Description",
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: blockWidth * 3),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Price",
                style: TextStyle(
                  fontSize: blockWidth * 6,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: blockWidth * 3),
              Container(
                width: blockWidth * 30,
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    hintText: "RS",
                  ),
                ),
              ),
              ],
            ),
            SizedBox(height: blockWidth * 5),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: blockWidth * 20,
        child: Center(
          child: SizedBox(
            width: blockWidth * 40,
            height: blockHeight * 10,
            child: Padding(
              padding: EdgeInsets.only(bottom: blockWidth * 5),
              child: RaisedButton(
                onPressed: (){
                  print("Save Button");
                },
                textColor: Colors.white,
                color: Color(0xffbb5e1e),
                child: Text(
                  'Add Item',
                  style: TextStyle(
                    fontSize: blockWidth * 3,
                    fontFamily: 'NunitoSans-SemiBold',
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(blockWidth * 6)
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget imageIcon(wTH, hTH) {
  return SizedBox(
      height: hTH * 25,
      width: wTH * 50,
      child: Container(
          padding: EdgeInsets.all(wTH * 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(wTH * 2),
              color: Color(0xffbb5e1e),
              border: Border.all(width: wTH * 0.5, color: Colors.black)),
          child: GestureDetector(
            onTap: (){
              print("Impport Image");
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: wTH * 16,
            ), 
          ),
    ),
  );
}