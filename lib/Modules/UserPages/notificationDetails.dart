import 'package:flutter/material.dart';

class NotiDetails extends StatefulWidget {
  List list;
  int index;
 List post;

  NotiDetails({Key key ,this.list,this.index, this.post}) : super(key: key);

  @override
  _NotiDetailsState createState() => _NotiDetailsState();
}

class _NotiDetailsState extends State<NotiDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("Notification Details"),
),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topCenter,
                          child: Container(
                height: 150,
                child: Card(
                  color: Colors.green[50],
                            child: Column(
                              children: [
                                SizedBox(height: 30,),
                                Text(
                    widget.post[widget.index]['title']
                  ),
                  SizedBox(height: 30,),
                   Align(
                     alignment: Alignment.centerLeft,
                                    child: Text(
                      widget.post[widget.index]['discription']
                  ),
                   ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      
                    widget.post[widget.index]['time'],
                    style: TextStyle(
                      color: Colors.blue
                    ),
                  ),
                  )
                              ],
                            ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




//ServiceNotification



class ServiceNotiDetails extends StatefulWidget {
  List list;
  int index;
 List post;

  ServiceNotiDetails({Key key ,this.list,this.index, this.post}) : super(key: key);

  @override
  _ServiceNotiDetailsState createState() => _ServiceNotiDetailsState();
}

class _ServiceNotiDetailsState extends State<ServiceNotiDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("Notification Details"),
),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topCenter,
                          child: Container(
                height: 150,
                child: Card(
                  color: Colors.green[50],
                            child: Column(
                              children: [
                                SizedBox(height: 30,),
                                Text(
                    widget.post[widget.index]['titleS']
                  ),
                  SizedBox(height: 30,),
                   Align(
                     alignment: Alignment.centerLeft,
                                    child: Text(
                      widget.post[widget.index]['discriptionS']
                  ),
                   ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      
                    widget.post[widget.index]['timeS'],
                    style: TextStyle(
                      color: Colors.blue
                    ),
                  ),
                  )
                              ],
                            ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

