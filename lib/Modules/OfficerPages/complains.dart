import 'dart:convert';
import 'package:cleancityapp2/Modules/OfficerPages/report.dart';
import 'package:cleancityapp2/auth/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Complains extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Complains> {
  TextEditingController comment = TextEditingController();
  Future<List> getData() async {
    final responce = await http.get(Uri.parse(
        "https://mychoir2.000webhostapp.com/cityClean/getComments.php"));

    var dat = json.decode(responce.body);
    return dat;

    // Showing Alert Dialog with Response JSON Message.
  }

  _comment() async {
    var url =
        'https://mychoir2.000webhostapp.com/cityClean/officerComments.php';

    http.post(Uri.parse(url), body: {
      "fname": name2,
      "lname": name,
      "email": email2,
      "comments": comment.text,
    });
  }

  //toast
  toast() {
    Fluttertoast.showToast(
        msg: "Sent",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    // TextField(
                    //   decoration: InputDecoration(
                    //       border: InputBorder.none, hintText: 'Your Comment'),
                    // ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          toast();
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
      body: FutureBuilder(
        future: getData(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (context, i) {
                  return Card(
                    shadowColor: Colors.greenAccent,
                    elevation: 10,
                    color: Colors.white,
                    child: ExpansionTile(
                      backgroundColor: Colors.green[50],
                      title: Row(
                        children: [
                         CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
                      icon: Image.asset('lib/Assets/head.png'),
                      onPressed: () {},
                    )
        ), 
                          Text(
                            snap.data[i]['fname'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            snap.data[i]['lname'],
                          ),
                        ],
                      ),
                      subtitle: Text(snap.data[i]['email']),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              child: Text(
                                snap.data[i]['comment'],
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              maxLines: 50,
                              
                              // overflow: TextOverflow.ellipsis,
                              
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                     
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              snap.data[i]['time'],
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
