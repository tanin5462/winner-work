import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Matching extends StatefulWidget {
  @override
  _MatchingState createState() => _MatchingState();
}

class _MatchingState extends State<Matching> {
  @override
  void initState() {
    super.initState();
    loadVocab();
  }

  // Variable
  Firestore db = Firestore.instance;
  String positionId;
  List<Map<String, dynamic>> vocabData = [];
  int currentQuestion = 0;
  // Future
  Future<void> loadVocab() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    positionId = pref.getString("positionKey");
    db
        .collection("Vocabulary")
        .where("positionId", arrayContains: positionId)
        .getDocuments()
        .then((data) {
      data.documents.forEach((doc) {
        String correctAnswer = doc.data['vocab'];
        // String question = doc.data['meaning'];
        // Map<String, dynamic> finaldata = {
        //   'question': question,
        //   'answer1': correctAnswer
        // };
        List choiceTemp = [];
        choiceTemp.add(correctAnswer);
      });
    });
  }

  // Widget
  Widget showQuestion() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(5.0),
      ),
      alignment: Alignment.center,
      child: Text(
        "Question",
        style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: "Prompt",
            letterSpacing: 1.0),
      ),
    );
  }

  Widget showAnswer() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        answer("Dog"),
        answer("Cat"),
        answer("Fish"),
        answer("Cow"),
      ],
    );
  }

  Widget answer(String answer) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.26,
        constraints: BoxConstraints(maxWidth: 140),
        height: 100,
        child: Card(
          elevation: 8.0,
          child: Container(
            color: Colors.teal,
            alignment: Alignment.center,
            child: Text(
              answer,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Prompt",
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Winner English @work"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(FontAwesomeIcons.signOutAlt),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          showQuestion(),
          showAnswer(),
        ],
      ),
    );
  }
}
