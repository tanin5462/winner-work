import 'dart:async';

import 'package:flutter/material.dart';
import 'package:winner_atwork/screens/login.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  // Explicit

  @override
  void initState() {
    super.initState();
    goToLogin();
  }

  Future<void> goToLogin() async {
    Future.delayed(const Duration(seconds: 2), () {
// Here you can write your code
      MaterialPageRoute materialPageRoute = MaterialPageRoute(
        builder: (BuildContext context) => MyLogin(),
      );
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget showAppName() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "WINNER ENGLISH",
          style: TextStyle(
              fontSize: 36,
              letterSpacing: 2.5,
              fontFamily: "Prompt",
              color: Colors.white),
        ),
        Container(
          padding: EdgeInsets.all(7.0),
          child: Text(
            "@work",
            style: TextStyle(
                fontSize: 16.0,
                letterSpacing: 1.5,
                fontFamily: "Prompt",
                color: Colors.white),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: showAppName(),
            ),
          ],
        ),
      ),
    );
  }
}
