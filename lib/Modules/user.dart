import 'package:cleancityapp2/Modules/UserPages/paymentNotification.dart';
import 'package:cleancityapp2/Modules/UserPages/servicenotification.dart';
import 'package:cleancityapp2/Modules/UserPages/payment.dart';
import 'package:cleancityapp2/auth/login.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {

  Users({this.position, this.fname, this.lname});

  final String fname,lname;
  final String position;

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
   int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
   
     Center(
      child: ServiceNotifications(),
    ),

    Center(
      child: PaymentNotifications(),
    ),
    
    Center(
      child: Payments(),
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

        title:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Hello :",
                style: TextStyle(
                  fontSize: 16
                ),
                ),

                Text(
                 widget.fname,
                style: TextStyle(
                  fontSize: 23
                ),
                ),
            ],
          ), 
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
                      icon: Image.asset('lib/Assets/applogo.png'),
                      onPressed: () {},
                    )
        ), 
          // IconButton(icon: Icon(Icons.person), onPressed: (){}),
         

        actions: [
          
           PopupMenuButton(
                  shape:  RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                  color: Colors.green[800],
                  itemBuilder: (BuildContext bc) => [
                   
                   
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
            icon: Icon(Icons.notification_important),
            label: 'Service Notifications',
            backgroundColor: Colors.green,
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Payment Notifications',
            backgroundColor: Colors.green,
          ),
           
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
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
