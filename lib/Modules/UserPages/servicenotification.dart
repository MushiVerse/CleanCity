import 'dart:convert';

import 'package:cleancityapp2/Modules/UserPages/notificationDetails.dart';
import 'package:cleancityapp2/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class ServiceNotifications extends StatefulWidget {
  String name;
  List list;

  ServiceNotifications({this.name});
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<ServiceNotifications> {
  TextEditingController comment = TextEditingController();
  TextEditingController emailcontrol = TextEditingController();
  TextEditingController phonecontrol = TextEditingController();

  Color _colorContainer = Colors.blue;

  Future<List> getServiceNoti() async {
    final responce = await http.get(Uri.parse(
        "https://mychoir2.000webhostapp.com/cityClean/getNotificationService.php"));

    var dat = json.decode(responce.body);
    return dat;

    // Showing Alert Dialog with Response JSON Message.
  }

  _comment() async {
    var url = 'https://mychoir2.000webhostapp.com/cityClean/comment.php';

    http.post(Uri.parse(url), body: {
      "fname": name2,
      "lname": name,
      "email": email2,
      "comment": comment.text,
    });
  }

  // navigateNoti(AsyncSnapshot<dynamic> post) {
  //   Navigator.push(  context,MaterialPageRoute(
  //           builder: (context) => NotiDetails(
  //                 post: post,
  //               )));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: comment,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Your Comment'),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          _comment();
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Text(
                          "Comment",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.comment),
      ),
      body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: FutureBuilder(
            future: getServiceNoti(),
            builder: (context, snap) {
              if (snap.hasData) {
                return ListView.builder(
                    itemCount: snap.data.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          Card(
                            color: Colors.green[50],
                                                      child: ListTile(
                              onTap: () {
                                setState(() {
                                  _colorContainer = _colorContainer == Colors.red
                                      ? Colors.green
                                      : Colors.red;
                                });
                                Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new ServiceNotiDetails(
                                    post: snap.data,
                                    index: i,
                                  )
                                  //  navigateNoti(
                                  //           snap.data[i])
                                  ,
                                ));
                              },
                              title: Text(snap.data[i]["titleS"]),
                              trailing: Text(
                                snap.data[i]['timeS'].toString(),
                                style: TextStyle(color: _colorContainer),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }
}
