import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winner_atwork/screens/joblist.dart';
import 'package:winner_atwork/screens/login.dart';
import 'package:winner_atwork/screens/userinfoheader.dart';

class MyUserMain extends StatefulWidget {
  @override
  _MyUserMainState createState() => _MyUserMainState();
}

class _MyUserMainState extends State<MyUserMain> {
  // Explicit
  List<Map<String, dynamic>> jobsName = [];
  List<Map<String, dynamic>> jobStar = [];
  Firestore db = Firestore.instance;

  String userId = "";
  Widget userHeader = UserInfoHeader();
  Widget jobList = JobList();

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('accountKey');
    pref.remove('name');
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext context) => MyLogin());
    Navigator.of(context)
        .pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('accountKey');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[userHeader, jobList],
          ),
        ),
      ),
    );
  }
}
