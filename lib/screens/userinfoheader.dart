import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoHeader extends StatefulWidget {
  @override
  _UserInfoHeaderState createState() => _UserInfoHeaderState();
}

class _UserInfoHeaderState extends State<UserInfoHeader> {
// Explicit
  String name = "";
  int star = 0;
  Firestore db = Firestore.instance;
  String userId = "";

  @override
  void initState() {
    super.initState();
    getName();
  }

  // Methods

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

  Future getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString('name');
      star = pref.getInt('star');
      userId = pref.getString('accountKey');
      if (star == null) {
        star = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return showUserInfo();
  }
}
