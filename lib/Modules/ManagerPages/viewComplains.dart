import 'dart:convert';
import 'package:cleancityapp2/Modules/OfficerPages/report.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ViewComplains extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<ViewComplains> {
  Future<List> getData() async {
    final responce = await http.get(Uri.parse(
        "https://mychoir2.000webhostapp.com/cityClean/getOfficerComment.php"));

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
                            Container(
                              width: 300,
                              
                              child: Text(
                                snap.data[i]['comments'],
                                maxLines: 20,
                                
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
