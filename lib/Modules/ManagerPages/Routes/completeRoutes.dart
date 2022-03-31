import 'dart:convert';

import 'package:cleancityapp2/Loadings/loading1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CompleteRoutes extends StatefulWidget {
  const CompleteRoutes({Key key}) : super(key: key);

  @override
  _RouteAnalysisState createState() => _RouteAnalysisState();
}

class _RouteAnalysisState extends State<CompleteRoutes> {
  Future<List> getData() async {
    final responce = await http.get(Uri.parse(
        "https://mychoir2.000webhostapp.com/cityClean/getCompletedRoutes.php"));

    var dat = json.decode(responce.body);
    return dat;

    // Showing Alert Dialog with Response JSON Message.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading1();
          } else {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                String boolAsString;
                bool b = boolAsString == snapshot.data[index]['bool'];
                // print(b);
                
                return Column(
                  children: [
                    Card(
                             child:Text(
                                  snapshot.data.length.toString(),
                                  style: TextStyle(
                                    fontSize: 26
                                  ),
                                ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: new Card(
                        shadowColor: Colors.greenAccent,
                        elevation: 10,
                        color: Colors.white,
                        child: new Container(
                          padding: new EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              
                              ListTile(
                                title: Row(
                                  children: [
                                    Text(
                                      'Driver Name: ',
                                    ),
                                    Text(
                                      snapshot.data[index]['fname'],
                                      style: TextStyle(
                                        fontSize: 26
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      snapshot.data[index]['lname'],
                                      style: TextStyle(
                                        fontSize: 26
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  snapshot.data[index]['time'],
                                ),
                               
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
