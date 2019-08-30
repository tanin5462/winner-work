import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winner_atwork/screens/worldlist.dart';

class JobList extends StatefulWidget {
  @override
  _JobListState createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  List<Map<String, dynamic>> jobsName = [];
  List<Map<String, dynamic>> jobStar = [];
  Firestore db = Firestore.instance;
  String userId = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userId = pref.getString('accountKey');
    loadJobs();
  }

  Future<void> loadJobs() async {
    db
        .collection("Position")
        .where("status", isEqualTo: true)
        .orderBy("orderid")
        .snapshots()
        .listen(
      (onData) {
        jobsName = [];
        onData.documents.forEach(
          (data) async {
            Map<String, dynamic> dataKey = {'key': data.documentID};
            Map<String, dynamic> dataFinal = {};

            dataFinal.addAll(dataKey);
            dataFinal.addAll(data.data);
            db
                .collection("CustomerPositionStar")
                .where("userId", isEqualTo: userId)
                .where("positionId", isEqualTo: data.documentID)
                .snapshots()
                .listen(
              (doc) {
                if (doc.documents.isNotEmpty) {
                  doc.documents.forEach(
                    (starData) {
                      Map<String, dynamic> starKey = {
                        'starKey': starData.documentID
                      };
                      Map<String, dynamic> dataStarFinal = {};
                      dataStarFinal.addAll(starKey);
                      dataStarFinal.addAll(starData.data);

                      Map<String, dynamic> dataMerge = {};
                      dataMerge.addAll(dataStarFinal);
                      dataMerge.addAll(dataFinal);
                      jobsName.add(dataMerge);
                    },
                  );
                } else {
                  setState(() {
                    Map<String, dynamic> dataMerge = {};
                    dataMerge.addAll(dataFinal);
                    dataMerge.addAll({'star': 0});
                    jobsName.add(dataMerge);
                  });
                }
              },
            );
          },
        );
      },
    );
  }

  Future<void> setJobKey(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("positionKey", key);
  }

  Widget jobList() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        // for (var item in jobsName) showJobsCard(item)
        for (var i = 0; i < jobsName.length; i++) showJobsCard(jobsName[i], i)
      ],
    );
  }

  Widget showJobsCard(Map<String, dynamic> item, int index) {
    return Container(
      padding: EdgeInsets.all(3.0),
      margin: EdgeInsets.only(top: 3.0, left: 3.0, right: 3.0),
      alignment: Alignment.center,
      child: RaisedButton(
        color: Colors.blue[800],
        textColor: Colors.white,
        padding: EdgeInsets.all(10.0),
        onPressed: () {
          setState(() {
            setJobKey(item['key']);
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyWorldList(item['key'], item['name']),
            );
            Navigator.of(context).push(materialPageRoute);
          });
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(
                  item['name'].toString(),
                  style: TextStyle(fontFamily: "Prompt", letterSpacing: 0.8),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                FontAwesomeIcons.solidStar,
                size: 24.0,
                color: Colors.amber,
              ),
            ),
            Container(
              width: 35,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                item['star'].toString(),
                style: TextStyle(fontFamily: "Prompt", letterSpacing: 0.8),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return jobList();
  }
}
