import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winner_atwork/screens/main.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String username, password;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  // Methods
  Widget usernameText() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Username",
          icon: Icon(Icons.person),
        ),
        onSaved: (String value) {
          username = value.trim();
        },
      ),
    );
  }

  Widget mySizeBox() {
    return Container(
      height: 8.0,
      width: 8.0,
    );
  }

  Widget passwordText() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          icon: Icon(Icons.lock),
        ),
        onSaved: (String value) {
          password = value.trim();
        },
      ),
    );
  }

  Widget loginForm() {
    return Center(
      child: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width * 0.9,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                usernameText(),
                mySizeBox(),
                passwordText(),
                mySizeBox(),
                loginButton(),
                mySizeBox(),
                forgotPassword(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Container(
      child: RaisedButton(
        color: Colors.teal,
        onPressed: () {
          formKey.currentState.save();
          // print("username = $username , password = $password");
          login();
        },
        child: Text(
          "เข้าสู่ระบบ",
          style: TextStyle(fontFamily: "Prompt", color: Colors.white),
        ),
      ),
    );
  }

  Future<void> checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accountKey = pref.getString('accountKey');
    if (accountKey != null) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyUserMain());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  Future<void> login() async {
    Firestore db = Firestore.instance;
    SharedPreferences pref = await SharedPreferences.getInstance();
    // print("username = $username , password = $password");
    db
        .collection("Accounts")
        .where("username", isEqualTo: username)
        .where("password", isEqualTo: password)
        .snapshots()
        .listen(
      (data) {
        if (data.documents.isEmpty == false) {
          data.documents.forEach(
            (doc) {
              if (doc.exists) {
                pref.setString('accountKey', doc.documentID);
                pref.setString(
                  'name',
                  doc.data['name'] + " " + doc.data['surname'],
                );
                MaterialPageRoute materialPageRoute = MaterialPageRoute(
                    builder: (BuildContext context) => MyUserMain());
                Navigator.of(context).pushAndRemoveUntil(
                    materialPageRoute, (Route<dynamic> route) => false);
              }
            },
          );
        } else {
          loginFailedAlert();
        }
      },
    );
  }

  Future<void> loginFailedAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'แจ้งเตือน',
            style: TextStyle(
                fontFamily: "Prompt",
                letterSpacing: 2.5,
                color: Colors.black87),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(
                    'รหัสผ่านผิดพลาด',
                    style: TextStyle(
                        fontFamily: "Prompt",
                        letterSpacing: 2.5,
                        color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'ตกลง',
                style: TextStyle(
                    fontFamily: "Prompt",
                    letterSpacing: 2.5,
                    color: Colors.black87),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget forgotPassword() {
    return FlatButton(
      child: Container(
        child: Text(
          "ลืมรหัสผ่าน",
          style: TextStyle(
            fontFamily: "Prompt",
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      onPressed: () {},
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                loginForm(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
