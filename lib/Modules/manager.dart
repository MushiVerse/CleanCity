import 'package:cleancityapp2/Modules/ManagerPages/checkPayments.dart';
import 'package:cleancityapp2/Modules/ManagerPages/Reports/report.dart';
import 'package:cleancityapp2/Modules/ManagerPages/viewComplains.dart';
import 'package:cleancityapp2/Modules/ManagerPages/registerUsers.dart';
import 'package:cleancityapp2/Modules/ManagerPages/notification.dart';
import 'package:cleancityapp2/auth/login.dart';
import 'package:flutter/material.dart';

import 'ManagerPages/routeAnalysisPages.dart';

class Manager extends StatelessWidget {
  // @override
  // _ManagerState createState() => _ManagerState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Managing(),
    );
  }
}

class Managing extends StatefulWidget {
  Managing({this.name, this.position});

  final String name;
  final String position;

  @override
  _ManagingState createState() => _ManagingState();
}

class _ManagingState extends State<Managing> {
  TextEditingController positioncontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    positioncontrol.text = position;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [IconButton(icon: Icon(Icons.person), onPressed: () {})],
        ),
        drawer: Drawer(
          elevation: 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                'Karibu : $position $name',
                style: TextStyle(color: Colors.white),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.green
              //   ),
              //   child: Text(
              //     "hey"
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),

              ListTile(
                trailing: Icon(Icons.link),
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: Text(
                  "My Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/Login");
                },
                tileColor: Colors.green,
                title: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: GridView.custom(
          physics: BouncingScrollPhysics(),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          childrenDelegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterUser()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text(
                          "Register Occupants",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewComplains()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red[800],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.compare_outlined),
                        Text(
                          "View Complain",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => RouteAnalysis()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.directions),
                        Text(
                          "Route Analysis",
                          style: TextStyle(
                              color: Colors.brown,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Report()));
                  },
                                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.book),
                        Text(
                          "Report",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SendNotification()));
                    
                  },
                                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications),
                        Text(
                          "Send Notification",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CheckPayment()));
                  },
                                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[800],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.payment),
                        Text(
                          "Check Payment",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
// class _ManagerState extends State<Manager> {
//   TextEditingController positioncontrol = TextEditingController();
//   List<Widget> images = [
//     Center(
//       child: Icon(Icons.add),
//     ),
//     // "https://uae.microless.com/cdn/no_image.jpg",
//     // "https://images-na.ssl-images-amazon.com/images/I/81aF3Ob-2KL._UX679_.jpg",
//     // "https://www.boostmobile.com/content/dam/boostmobile/en/products/phones/apple/iphone-7/silver/device-front.png.transform/pdpCarousel/image.jpg",
//     // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgUgs8_kmuhScsx-J01d8fA1mhlCR5-1jyvMYxqCB8h3LCqcgl9Q",
//     // "https://ae01.alicdn.com/kf/HTB11tA5aiAKL1JjSZFoq6ygCFXaw/Unlocked-Samsung-GALAXY-S2-I9100-Mobile-Phone-Android-Wi-Fi-GPS-8-0MP-camera-Core-4.jpg_640x640.jpg",
//     // "https://media.ed.edmunds-media.com/gmc/sierra-3500hd/2018/td/2018_gmc_sierra-3500hd_f34_td_411183_1600.jpg",
//     // "https://hips.hearstapps.com/amv-prod-cad-assets.s3.amazonaws.com/images/16q1/665019/2016-chevrolet-silverado-2500hd-high-country-diesel-test-review-car-and-driver-photo-665520-s-original.jpg",
//     // "https://www.galeanasvandykedodge.net/assets/stock/ColorMatched_01/White/640/cc_2018DOV170002_01_640/cc_2018DOV170002_01_640_PSC.jpg",
//     // "https://media.onthemarket.com/properties/6191869/797156548/composite.jpg",
//     // "https://media.onthemarket.com/properties/6191840/797152761/composite.jpg",
//   ];

//   String position;

//   @override
//   Widget build(BuildContext context) {

//   }
// }
