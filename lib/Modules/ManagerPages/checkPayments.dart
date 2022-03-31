import 'package:cleancityapp2/Modules/ManagerPages/CheckPaySts/paid.dart';
import 'package:cleancityapp2/Modules/ManagerPages/CheckPaySts/unpaid.dart';
import 'package:flutter/material.dart';  
import 'package:cleancityapp2/Modules/ManagerPages/sendPaymentNotification.dart';
import 'package:cleancityapp2/Modules/ManagerPages/sendServiceNotification.dart';

class CheckPayment extends StatefulWidget {  
  CheckPayment({Key key}) : super(key: key);  
  
  @override  
  _MyNavigationBarState createState() => _MyNavigationBarState();  
}  
  
class _MyNavigationBarState extends State<CheckPayment> {  
  int _selectedIndex = 0;  
  static List<Widget> _widgetOptions = <Widget>[  
    Center(
      child: Paid(),
    ),
    Center(
      child: UnPaid(),
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
        title: const Text('Check Payments'),  
          backgroundColor: Colors.green  
      ),  
      body: Center(  
        child: _widgetOptions.elementAt(_selectedIndex),  
      ),  
      bottomNavigationBar: BottomNavigationBar(  
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.payment),  
            label: 'Paid',  
            backgroundColor: Colors.white  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.cleaning_services),  
            label: 'Unpaid',  
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