import 'package:flutter/material.dart';  
import 'package:cleancityapp2/Modules/ManagerPages/sendPaymentNotification.dart';
import 'package:cleancityapp2/Modules/ManagerPages/sendServiceNotification.dart';

class SendNotification extends StatefulWidget {  
  SendNotification ({Key key}) : super(key: key);  
  
  @override  
  _MyNavigationBarState createState() => _MyNavigationBarState();  
}  
  
class _MyNavigationBarState extends State<SendNotification> {  
  int _selectedIndex = 0;  
  static List<Widget> _widgetOptions = <Widget>[  
    Center(
      child: SendPaymentNotificationn(),
    ),
    Center(
      child: SendServiceNotificationn(),
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
        title: const Text('Sending Notifications'),  
          backgroundColor: Colors.green  
      ),  
      body: Center(  
        child: _widgetOptions.elementAt(_selectedIndex),  
      ),  
      bottomNavigationBar: BottomNavigationBar(  
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.payment),  
            title: Text('Payment Notification'),  
            backgroundColor: Colors.green  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.cleaning_services),  
            title: Text('Service Notification'),  
            backgroundColor: Colors.grey  
          ),  
         
        ],  
        type: BottomNavigationBarType.shifting,  
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.black,  
        iconSize: 40,  
        onTap: _onItemTapped,  
        elevation: 5  
      ),  
    );  
  }  
}  