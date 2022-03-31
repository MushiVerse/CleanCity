import 'package:cleancityapp2/Loadings/loading.dart';
import 'package:cleancityapp2/Modules/driverDetails.dart';
import 'package:cleancityapp2/auth/login.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cleancityapp2/Modules/OfficerPages/report.dart';
import 'package:http/http.dart' as http;


class Driver extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Driver> {

  Future<List> getData() async {
    final responce = await http.get(Uri.parse(
        "https://mychoir2.000webhostapp.com/cityClean/getRegisterers.php"));

    var dat = json.decode(responce.body);
    return dat;

    // Showing Alert Dialog with Response JSON Message.
  }

  // _statusing() async {
  //   var url = 'https://mychoir2.000webhostapp.com/cityClean/routeStatus.php';

  //   http.post(Uri.parse(url), body: {
  //     "fname": name2,
  //     "lname": name,
  //     "cname": widget.post[widget.index]['fname'],
  //     "email": email2,
  //     "booli": _isChecked[0].toString(),
  //   });
  // }
  

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0,
        leading: CircleAvatar(
          child: IconButton(
                      icon: Image.asset('lib/Assets/applogo.png'),
                      onPressed: () {},
                    ),
          backgroundColor: Colors.white,),
        // IconButton(

        //   icon: Icon(
        //   Icons.person
        // ), onPressed: (){}),
        backgroundColor: Colors.green[900],
        // title: Text(
        //   "Transport Status",
        //   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        //   ),

        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.green[800],
            itemBuilder: (BuildContext bc) => [
              
              PopupMenuItem(
                  child: Text(
                    "LogOut",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  value: "/Login"),
            ],
            onSelected: (route) {
              print(route);
              Navigator.pushNamed(context, route);
            },
          ),
        ],

        title: Row(
          children: [
            Container(
              
            child: Column(
              children: [
                Row(
                  children: [
                     new Text('Hello '),
            new Text('$name ',
            style: TextStyle(fontSize: 24,
            fontWeight: FontWeight.bold
            ),
            ),

                  ],
                ),
                
            new Text('Here is your Todo List ',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            )
              ],

            ),
            )
           
          ],
        ),
      ),
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
                            snap.data[i]['street'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          
                        ],
                      ),
                      subtitle: Text(snap.data[i]['lname']),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(snap.data[i]['email']),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DriverDetails(
                                  post: snap.data,
                                    index: i,
                                )));
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