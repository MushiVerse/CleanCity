import 'package:cleancityapp2/Loadings/loading.dart';
import 'package:cleancityapp2/Loadings/loading1.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cleancityapp2/Modules/OfficerPages/report.dart';
import 'package:http/http.dart' as http;

class UnPaid extends StatefulWidget {
  const UnPaid({Key key}) : super(key: key);

  @override
  _CheckPaymentState createState() => _CheckPaymentState();
}

class _CheckPaymentState extends State<UnPaid> {
  Future<List> getData() async {
    final responce = await http.get(Uri.parse(
        "https://mychoir2.000webhostapp.com/cityClean/getReg.php"));

    var dat = json.decode(responce.body);
    return dat;

    // Showing Alert Dialog with Response JSON Message.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: getData(),
            builder: (cxt, snap) {
              if (snap.connectionState != ConnectionState.done) {
                return Center(child: Loading1());
              } else {
                return ListView.builder(
                    itemCount: snap.data.length,
                    itemBuilder: (cxt, i) {
                      return Card(
                                              child: ListTile(
                          title: Text(snap.data[i]['fname']),
                          subtitle: Text(
                            snap.data[i]['time'],
                            style: TextStyle(color: Colors.green),
                            ) ,
                          ),
                      );
                    });
              }
            }),
      ),
    );
  }
}






class CheckPayment extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<CheckPayment> {
  Future<List> getData() async {
    final responce = await http.get(Uri.parse(
        "https://mychoir2.000webhostapp.com/cityClean/getRegisterers.php"));

    var dat = json.decode(responce.body);
    return dat;

    // Showing Alert Dialog with Response JSON Message.
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
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
                            backgroundColor: Colors.green,
                            maxRadius: 24,
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
                            Text(snap.data[i]['street']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Reports()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "View",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.forward),
                            ],
                          ),
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

