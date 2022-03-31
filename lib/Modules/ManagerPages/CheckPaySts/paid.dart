import 'package:cleancityapp2/Loadings/loading.dart';
import 'package:cleancityapp2/Loadings/loading1.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cleancityapp2/Modules/OfficerPages/report.dart';
import 'package:http/http.dart' as http;

class Paid extends StatefulWidget {
  const Paid({Key key}) : super(key: key);

  @override
  _CheckPaymentState createState() => _CheckPaymentState();
}

class _CheckPaymentState extends State<Paid> {
  Future<List> getData() async {
    final responce = await http.get(Uri.parse(
        "https://mychoir2.000webhostapp.com/cityClean/getRegisterers.php"));

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
                return Column(
                  children: [
                    Container(
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snap.data.length.toString()),
                          Text('  Customers Paid')
                        ],
                      )),
                      height: 220,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0)),
                          gradient: LinearGradient(
                              colors: [Colors.green, Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: snap.data.length,
                          itemBuilder: (cxt, i) {
                            return Card(
                              child: ListTile(
                                title: Text(snap.data[i]['fname']),
                                subtitle: Text(
                                  snap.data[i]['time'],
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}
