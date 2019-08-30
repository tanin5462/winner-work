import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winner_atwork/screens/matching.dart';

class MyLesson extends StatefulWidget {
  final String jobName, world;
  MyLesson(this.jobName, this.world);
  @override
  _MyLessonState createState() =>
      _MyLessonState(jobName: this.jobName, world: this.world);
}

class _MyLessonState extends State<MyLesson> {
  // Explicit
  String jobName, world;
  _MyLessonState({this.jobName, this.world});

  // Widget
  Widget headerCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        color: Colors.teal,
      ),
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          showWorldIcon(),
          showWorldName(world),
        ],
      ),
    );
  }

  Widget showWorldIcon() {
    return Container(
      color: Colors.teal[600],
      alignment: Alignment.center,
      width: 80,
      child: Text(
        world,
        style: TextStyle(
          fontSize: 55,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
          fontFamily: "Prompt",
        ),
      ),
    );
  }

  Widget showStarBar() {
    return Container(
      padding: EdgeInsets.all(3.0),
      alignment: Alignment.center,
      width: 220,
      height: 25,
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
            size: 16,
          ),
          Container(
            width: 5.0,
          ),
          Text(
            "0/100",
            style: TextStyle(
                color: Colors.white, fontFamily: "Prompt", letterSpacing: 1.0),
          ),
        ],
      ),
    );
  }

  Widget showWorldName(String world) {
    if (world == "D") {
      return Expanded(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                "Diaglog",
                style: TextStyle(
                    fontFamily: "Prompt",
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.8,
                    fontSize: 16),
              ),
              showStarBar(),
            ],
          ),
        ),
      );
    } else if (world == "V") {
      return Expanded(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                "Vocabulary",
                style: TextStyle(
                    fontFamily: "Prompt",
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.8,
                    fontSize: 16),
              ),
              showStarBar(),
            ],
          ),
        ),
      );
    } else if (world == "W") {
      return Expanded(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                "Writing",
                style: TextStyle(
                    fontFamily: "Prompt",
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.8,
                    fontSize: 16),
              ),
              showStarBar(),
            ],
          ),
        ),
      );
    } else if (world == "S") {
      return Expanded(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                "Speaking",
                style: TextStyle(
                    fontFamily: "Prompt",
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.8,
                    fontSize: 16),
              ),
              showStarBar(),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget starBar() {
    return Container(
      child: Row(
        children: <Widget>[],
      ),
    );
  }

  Widget lessonDivider() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Lesson",
            style: TextStyle(fontFamily: "Prompt", fontSize: 24),
          ),
          Container(
            color: Colors.black87,
            height: 4,
          ),
        ],
      ),
    );
  }

  Widget showLessonCard() {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: <Widget>[
        for (var i = 0; i < 16; i++) lessonCard(i),
      ],
    );
  }

  Widget lessonCard(int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          if (world == "V") {
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
                builder: (BuildContext context) => Matching());
            Navigator.of(context).push(materialPageRoute);
          }
        }
      },
      child: Container(
        width: 120,
        height: 120,
        child: Card(
          elevation: 8.0,
          color: checkColors(index),
          child: Container(
            alignment: Alignment.center,
            child: testCondition(index),
          ),
        ),
      ),
    );
  }

  Color checkColors(int index) {
    if (index != 0) {
      return Colors.grey;
    } else {
      return Colors.teal;
    }
  }

  Widget testCondition(int index) {
    if (index != 0) {
      return Icon(
        FontAwesomeIcons.lock,
        size: 40,
        color: Colors.white60,
      );
    } else {
      return Text(
        (index + 1).toString(),
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Prompt",
            letterSpacing: 1.0,
            fontSize: 40),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(jobName),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          headerCard(),
          lessonDivider(),
          showLessonCard(),
        ],
      ),
    );
  }
}
