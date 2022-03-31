import 'package:cleancityapp2/Modules/OfficerPages/complains.dart';
import 'package:cleancityapp2/Modules/OfficerPages/report.dart';
import 'package:cleancityapp2/auth/login.dart';
import 'package:flutter/material.dart';

class Officer extends StatefulWidget {
  final String name, position;
  Officer({this.name, this.position});
  @override
  _ManagerState createState() => _ManagerState();
}

class _ManagerState extends State<Officer> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Complains(),
    ),
    Center(
      child: Reports(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        foregroundColor: Colors.green,
        leading: PopupMenuButton(
            
            child: CircleAvatar(
              backgroundColor: Colors.white,
               child: IconButton(
                      icon: Image.asset('lib/Assets/applogo.png'),
                      onPressed: () {},
                    ),
            radius: 23,
            ),
            // icon: Icon(Icons.person),
                  shape:  RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                  color: Colors.black,
                  itemBuilder: (BuildContext bc) => [
                    PopupMenuItem(
                        child: Row(
                          children: [
                            Text(
                              "Hey ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            Text(
                              "$name",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        value: ""),
                  
                    PopupMenuItem(
                        child: Text("LogOut",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ), value: "/Login"),
                  ],
                  onSelected: (route) {
                    print(route);
                    Navigator.pushNamed(context, route);
                  },
                ), 
        actions: [
          
          PopupMenuButton(
            
            
            // icon: Icon(Icons.person),
                  shape:  RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                  color: Colors.black,
                  itemBuilder: (BuildContext bc) => [
                    PopupMenuItem(
                        child: Row(
                          children: [
                            Text(
                              "Hey ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            Text(
                              "$name",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        value: ""),
                  
                    PopupMenuItem(
                        child: Text("LogOut",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ), value: "/Login"),
                  ],
                  onSelected: (route) {
                    print(route);
                    Navigator.pushNamed(context, route);
                  },
                ), 

        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Complains',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Report',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
