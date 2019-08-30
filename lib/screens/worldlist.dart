import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winner_atwork/screens/lessonmain.dart';
import 'package:winner_atwork/screens/userinfoheader.dart';

class MyWorldList extends StatefulWidget {
  final String jobKey;
  final String jobName;
  MyWorldList(this.jobKey, this.jobName);
  @override
  _MyWorldListState createState() =>
      _MyWorldListState(jobKey: this.jobKey, jobName: this.jobName);
}

class _MyWorldListState extends State<MyWorldList> {
  // Variable
  Widget userHeader = UserInfoHeader();
  String jobKey;
  String jobName;
  TextStyle textWihte = TextStyle(
    color: Colors.white,
  );
  _MyWorldListState({this.jobKey, this.jobName});
  Firestore db = Firestore.instance;
  Map<String, dynamic> userWorldStarData;

  // Future

  @override
  void initState() {
    super.initState();
    loadUserWorldStar();
  }

  Future<void> loadUserWorldStar() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString('accountKey');
    print("userid = $userId , jobkey= $jobKey");
    db
        .collection("CustomerWorldStar")
        .where("userId", isEqualTo: userId)
        .where("positionId", isEqualTo: jobKey)
        .snapshots()
        .listen((response) {
      if (response.documents.isEmpty) {
        setState(() {
          userWorldStarData = {
            'vocab': 0,
            'dialog': 0,
            'speaking': 0,
            'writing': 0
          };
        });
      } else {
        response.documents.forEach((doc) {
          if (doc.exists) {
            setState(() {
              userWorldStarData = doc.data;
            });
          }
        });
      }
    });
  }

  // Widget

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
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => MyLesson(jobName, world),
            );
            Navigator.of(context).push(materialPageRoute);
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
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: Colors.grey[800],
            ),
            padding: EdgeInsets.all(3),
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.solidStar,
                  color: Colors.amber,
                  size: 18,
                ),
                Container(
                  width: 5,
                ),
                showStarNumber(world)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget showStarNumber(String world) {
    if (world == "V") {
      return Text(
        userWorldStarData['vocab'].toString(),
        style:
            TextStyle(fontFamily: "Prompt", color: Colors.white, fontSize: 16),
      );
    } else if (world == "D") {
      return Text(
        userWorldStarData['dialog'].toString(),
        style:
            TextStyle(fontFamily: "Prompt", color: Colors.white, fontSize: 16),
      );
    } else if (world == "S") {
      return Text(
        userWorldStarData['speaking'].toString(),
        style:
            TextStyle(fontFamily: "Prompt", color: Colors.white, fontSize: 16),
      );
    } else {
      return Text(
        userWorldStarData['writing'].toString(),
        style:
            TextStyle(fontFamily: "Prompt", color: Colors.white, fontSize: 16),
      );
    }
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

  Widget showJobName() {
    return Text(
      jobName,
      style: TextStyle(fontSize: 20, fontFamily: "Prompt", letterSpacing: 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: showJobName(),
      ),
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
