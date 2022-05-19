import 'package:flutter/material.dart';  
import 'package:cleancityapp2/Modules/ManagerPages/Routes/completeRoutes.dart';
import 'package:cleancityapp2/Modules/ManagerPages/Routes/IncompleteRoutes.dart';

class RouteAnalysis extends StatefulWidget {  
  RouteAnalysis ({Key key}) : super(key: key);  
  
  @override  
  _MyNavigationBarState createState() => _MyNavigationBarState();  
}  
  
class _MyNavigationBarState extends State<RouteAnalysis> {  
  int _selectedIndex = 0;  
  static List<Widget> _widgetOptions = <Widget>[  
    Center(
      child: CompleteRoutes(),
    ),
    Center(
      child: IncompleRoutes(),
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
      backgroundColor: Colors.white, 
      appBar: AppBar(  
        title: const Text('Route Analysis'),  
          backgroundColor: Colors.green  
      ),  
      body: Center(  
        child: _widgetOptions.elementAt(_selectedIndex),  
      ),  
      bottomNavigationBar: BottomNavigationBar(  
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.done,
            color: Colors.green,
            ),  
            label: 'Completed',  
            backgroundColor: Colors.white  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.not_interested_rounded,
            color: Colors.red,
            ),  
            label: 'Incompleted',  
            backgroundColor: Colors.white  
          ),  
         
        ],  
        type: BottomNavigationBarType.fixed,  
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.black,  
        iconSize: 40,  
        onTap: _onItemTapped,  
        elevation: 5  
      ),  
    );  
  }  
}  