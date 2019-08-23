import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winner_atwork/screens/userinfoheader.dart';

class MyWorldList extends StatefulWidget {
  final String jobKey;
  MyWorldList(this.jobKey);
  @override
  _MyWorldListState createState() => _MyWorldListState(jobKey: this.jobKey);
}

class _MyWorldListState extends State<MyWorldList> {
  Widget userHeader = UserInfoHeader();
  String jobKey;
  TextStyle textWihte = TextStyle(
    color: Colors.white,
  );
  _MyWorldListState({this.jobKey});

  Widget worldCardShow() {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: <Widget>[
        worldCard("V"),
        worldCard("D"),
        worldCard("S"),
        worldCard("W"),
      ],
    );
  }

  Widget worldCard(String world) {
    return GestureDetector(
      onTap: () {
        print("TAPTAP");
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        constraints: BoxConstraints(maxWidth: 200),
        height: 150,
        child: Card(
          color: Colors.cyan[600],
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    showWorldName(world),
                  ],
                ),
              ),
              Positioned(
                bottom: 7,
                right: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.all(3),
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Container(
                        width: 5,
                      ),
                      Text(
                        "0 / 100",
                        style: textWihte,
                      ),
                    ],
                  ),
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showWorldName(String world) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            world,
            style: TextStyle(
                fontSize: 55,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: "Prompt"),
          ),
          if (world == "V")
            Text(
              "Vocabulary",
              style: TextStyle(
                  fontFamily: "Prompt",
                  color: Colors.white,
                  letterSpacing: 0.8,
                  fontSize: 16),
            ),
          if (world == "D")
            Text(
              "Diaglog",
              style: TextStyle(
                  fontFamily: "Prompt",
                  color: Colors.white,
                  letterSpacing: 0.8,
                  fontSize: 16),
            ),
          if (world == "S")
            Text(
              "Speaking",
              style: TextStyle(
                  fontFamily: "Prompt",
                  color: Colors.white,
                  letterSpacing: 0.8,
                  fontSize: 16),
            ),
          if (world == "W")
            Text(
              "Writing",
              style: TextStyle(
                  fontFamily: "Prompt",
                  color: Colors.white,
                  letterSpacing: 0.8,
                  fontSize: 16),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[userHeader, worldCardShow()],
          ),
        ),
      ),
    );
  }
}
