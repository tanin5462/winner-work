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

  // Methods
  Widget userInfo() {
    return Center(
      child: Container(
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

  Widget userName() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          "Tanin Sangpho",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Prompt",
              fontSize: 24,
              letterSpacing: 1.5),
        ),
      ),
    );
  }

  Widget userHeader() {
    return Container(
      color: Colors.grey[800],
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: <Widget>[
          userPicture(),
          userName(),
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
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: <Widget>[
              userInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
