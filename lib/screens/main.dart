import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winner_atwork/screens/login.dart';

class MyUserMain extends StatefulWidget {
  @override
  _MyUserMainState createState() => _MyUserMainState();
}

class _MyUserMainState extends State<MyUserMain> {
  // Explicit
  String name = "";
  int star = 0;
  Firestore db = Firestore.instance;
  var jobsName = [];

  @override
  void initState() {
    super.initState();
    getName();
    loadJobs();
  }

  // Methods

  Future getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString('name');
      star = pref.getInt('star');
    });
  }

  Widget showUserInfo() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            userHeader(),
          ],
        ),
      ),
    );
  }

  Widget userPicture() {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.3,
      child: Image.asset(
        'images/avatar.png',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget userInfomation() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Prompt",
                  fontSize: 24,
                  letterSpacing: 1.5),
            ),
          ),
          mySizeBox(),
          userStar(),
        ],
      ),
    );
  }

  Widget mySizeBox() {
    return Container(
      height: 7.0,
    );
  }

  Widget userStar() {
    return Container(
      color: Colors.teal,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(
              FontAwesomeIcons.solidStar,
              size: 24.0,
              color: Colors.amber,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              star.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Prompt",
                  fontSize: 24,
                  letterSpacing: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget userHeader() {
    return Container(
      color: Colors.grey[800],
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: <Widget>[
          userPicture(),
          userInfomation(),
        ],
      ),
    );
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('accountKey');
    pref.remove('name');
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => MyLogin());
    Navigator.of(context)
        .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
  }

  Future<void> loadJobs() async {
    await db.collection("Jobs").getDocuments().then(
          (doc) => doc.documents.forEach(
            (data) {
              setState(() {
                jobsName.add(data.data['name']);
              });
            },
          ),
        );
  }

  Widget showStarInline() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              FontAwesomeIcons.solidStar,
              size: 24,
              color: Colors.amber,
            ),
          ),
          Container(
            width: 10,
          ),
          Container(
            child: Text(
              "100/100",
              style: TextStyle(letterSpacing: 0.8, fontFamily: "Prompt"),
            ),
          )
        ],
      ),
    );
  }

  Widget jobList() {
    return Column(
      children: <Widget>[
        showUserInfo(),
        Container(
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: jobsName.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(5.0),
                  child: RaisedButton(
                    color: Colors.blue[800],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(10.0),
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(jobsName[index]),
                          ),
                        ),
                        showStarInline()
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Winner English @Work"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
              size: 24.0,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          jobList(),
        ],
      ),
    );
  }
}
