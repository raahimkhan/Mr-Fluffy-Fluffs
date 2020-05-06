import 'package:flutter/material.dart';
import 'package:fluffs/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List msg = [
  {
    "Name": "Fluffy Pancake",
    "Position": 1,
    "Points": 30,
  },
  {
    "Name": "Nutella Pancake",
    "Position": 2,
    "Points": 20,
  },
  {
    "Name": "White Chocolate Chip Pancake",
    "Position": 3,
    "Points": 10,
  },
  {
    "Name": "Fluffy Pancake",
    "Position": 4,
    "Points": 5,
  },
  {
    "Name": "Fluffy Pancake",
    "Position": 4,
    "Points": 5,
  },
  {
    "Name": "Fluffy Pancake",
    "Position": 4,
    "Points": 5,
  },
  {
    "Name": "Fluffy Pancake",
    "Position": 4,
    "Points": 5,
  },
];

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  
  @override
  Widget build(BuildContext context) {

    // Variables for adjusting Screen width and Height according to different sizes

    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return Scaffold(
      // A ListView was used in this case instead of a column because we wanted this screen to scroll and this can't be done by using Columns

      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[

            // Rows were used here to correctly position the icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.keyboard_arrow_left, size: blockWidth * 10),
                  color: Colors.red[200],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,MaterialPageRoute(
                        builder: (context) => Profile(),
                      ),
                    );
                  },
                  icon: Icon(Icons.person, size: blockWidth * 8),
                  color: Colors.red[200],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(
                        FontAwesomeIcons.crown,
                        color: Color(0x73ff8000),
                        size: blockWidth * 30,
                      ),
                    SizedBox(height: blockWidth * 2.5),
                    Text(
                      "Leaderboard",
                      style: TextStyle(
                        fontSize: blockWidth * 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffbb5e1e),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: blockWidth * 5),
            Column(
              children: <Widget>[
                ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: msg == null ? 0 :msg.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map elem = msg[index];
                      return LeaderboardMenu(
                        name: elem['Name'],
                        pos: elem['Position'],
                        point: elem['Points'],
                      );
                    },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class LeaderboardMenu extends StatelessWidget {

  final name, pos, point;

  LeaderboardMenu({Key key, this.name, this.pos, this.point}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    var wTH = MediaQuery.of(context).size.width;
    var blockWidth = wTH / 100;
    return SizedBox(
      height: blockWidth * 20,
      child: Card(
        elevation: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: blockWidth * 2),
              child: Text(
                "$pos",
                style: TextStyle(
                  fontSize: blockWidth * 5,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: blockWidth * 3.8,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(right: blockWidth * 2.6),
              child: Text(
                "$point",
                style: TextStyle(
                  fontSize: blockWidth * 5,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

