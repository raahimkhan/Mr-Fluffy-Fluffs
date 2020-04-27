import 'package:flutter/material.dart';

Widget edit(item, wTH, hTH) {
  return Material(
    color: Colors.white,
    child: Builder(
      builder: (BuildContext context) {
        return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white, 
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    hintText: "Enter Old $item",
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(width: 0, height: 0),
              ),
            ],
          ),
          SizedBox(
            height: hTH * 0.02,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "New $item",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white, 
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    hintText: "Enter New $item",
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(width: 0, height: 0),
              ),
            ],
          ),
          SizedBox(
            height: hTH * 0.02,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Confirm $item",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white, 
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    hintText: "Confirm $item",
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(width: 0, height: 0),
              ),
            ],
          ),
          Card(
            child: Center(
              child: SizedBox(
                width: wTH * 0.3,
                height: hTH * 0.06,
                child: RaisedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  textColor: Colors.white,
                  color: Color(0xffbb5e1e),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontFamily: 'NunitoSansSemiBold',
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },),
  );
}