import 'dart:convert';

import 'package:cleancityapp2/Modules/UserPages/notificationDetails.dart';
import 'package:cleancityapp2/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class PaymentNotifications extends StatefulWidget {
  String name;
  List list;
  PaymentNotifications({this.name});
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<PaymentNotifications> {
  TextEditingController comment = TextEditingController();
  TextEditingController emailcontrol = TextEditingController();
  TextEditingController phonecontrol = TextEditingController();

  Future<List> getServiceNoti() async {
    final responce = await http.get(Uri.parse(
        "https://mychoir2.000webhostapp.com/cityClean/getNotificationpayments.php"));

    // var dat = json.decode(responce.body);
    // return dat;

    // Showing Alert Dialog with Response JSON Message.
  }

  setPaymentNotification() async {
    var url =
        'https://mychoir2.000webhostapp.com/cityClean/getNotificationpayments.php';

    http.post(Uri.parse(url), body: {
      "id": name2,
    });
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

  @override
  void initState() {
    setPaymentNotification();


    super.initState();
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
                                Navigator.of(context)
                                    .push(new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new NotiDetails(
                                    post: snap.data,
                                    index: i,
                                  )
                                  //  navigateNoti(
                                  //           snap.data[i])
                                  ,
                                ));
                              },
                              title: Text(snap.data[i]["title"]),
                              trailing: Text(
                                snap.data[i]['time'].toString(),
                                style: TextStyle(color: Colors.green),
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
