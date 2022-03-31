// import 'package:cleancityapp2/Loadings/loading.dart';
// import 'package:cleancityapp2/Loadings/loading1.dart';
// import 'package:cleancityapp2/Modules/DriverPages/GmapPage.dart';
// import 'package:cleancityapp2/auth/login.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';

// class Driver extends StatefulWidget {
//   final String name, position;
//   final List<CheckBoxListTileModel> datar;
//   Driver({this.name, this.position, this.datar});

//   @override
//   _DriverState createState() => _DriverState();
// }

// class _DriverState extends State<Driver> {
//   bool loading;

//   Future<List> getData() async {
//     final responce = await http.get(Uri.parse(
//         "https://mychoir2.000webhostapp.com/cityClean/getRegisterers.php"));

//     var dat = json.decode(responce.body);
//     return dat;

//     // Showing Alert Dialog with Response JSON Message.
//   }

//   void itemChange(bool val, int index) {
//     setState(() {
//       checkBoxListTileModel[index].isCheck = val;
//     });
//   }

//   List<CheckBoxListTileModel> checkBoxListTileModel =
//       CheckBoxListTileModel.getLocation();

//   bool _isSelected = false;

//   GoogleMapController _googleMapController;

//   Marker _origin;

//   Marker _destination;

//   @override
//   Widget build(context) {
//     return loading
//         ? Loading()
//         : ListView.builder(
//             physics: BouncingScrollPhysics(),
//             itemCount: widget.datar.length,
//             itemBuilder: (BuildContext context, int index) {
//               return createViewItem(widget.datar[index], context);
//             },
//           );
//   }

//   Widget createViewItem(CheckBoxListTileModel datee, BuildContext context) {
//     return new Scaffold(
//       backgroundColor: Colors.white,
//       appBar: new AppBar(
//         elevation: 0,
//         leading: Text(widget.name),
//         // IconButton(

//         //   icon: Icon(
//         //   Icons.person
//         // ), onPressed: (){}),
//         backgroundColor: Colors.green[700],
//         // title: Text(
//         //   "Transport Status",
//         //   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
//         //   ),

//         actions: [
//           PopupMenuButton(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0)),
//             color: Colors.green[800],
//             itemBuilder: (BuildContext bc) => [
//               PopupMenuItem(
//                   child: Text(
//                     "Share",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   value: ""),
//               PopupMenuItem(
//                 child: Text(
//                   "Settings",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 value: "/new-group-chat",
//               ),
//               PopupMenuItem(
//                   child: Text(
//                     "LogOut",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   value: "/Login"),
//             ],
//             onSelected: (route) {
//               print(route);
//               Navigator.pushNamed(context, route);
//             },
//           ),
//         ],

//         title: new Text('ToDo List'),
//       ),
//       body: FutureBuilder(
//         future: getData(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return new ListView.builder(
//               itemCount: checkBoxListTileModel.length,
//               itemBuilder: (context, i) {
//                 String street = datee.street;
//                 bool ischecked = false;
//                 String latlng = datee.latlong;
//                 String resiNo = snapshot.data[i]['resiNo'];
//                 // bool bol = snapshot.data[i]['bool'];

//                 Map<String, bool> values = {
//                   // street: bol,
//                   'bar': false,
//                   'Makulu': true,
//                 };

//                 // return new ListView(
//                 //     children: values.keys.map((String key) {
//                 //   return new CheckboxListTile(
//                 //     title: new Text(key),
//                 //     value: values[key],
//                 //     onChanged: (bool value) {
//                 //       setState(() {
//                 //        _isSelected = value;
//                 //       });
//                 //     },
//                 //   );
//                 // }).toList());

//                 return ExpansionTile(
//                   subtitle: Text(latlng),
//                   children: [
//                     ElevatedButton(
//                         style: ElevatedButton.styleFrom(primary: Colors.green),
//                         onPressed: () {
//                           Navigator.of(context).push(
//                               MaterialPageRoute(builder: (context) => GMap()));
//                         },
//                         child: Text('Get Location'))
//                   ],
//                   title: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.green,
//                           offset: const Offset(
//                             0.0,
//                             0.0,
//                           ), //Offset
//                           blurRadius: 10.0,
//                           spreadRadius: 1.0,
//                         ), //BoxShadow
//                         BoxShadow(
//                           color: Colors.white,
//                           offset: const Offset(0.0, 0.0),
//                           blurRadius: 0.0,
//                           spreadRadius: 3.0,
//                         ), //BoxShadow
//                       ],
//                     ), //
//                     child: new CheckboxListTile(
//                       title: new Text(street),
//                       value: ischecked,
//                       selected: ischecked,
//                       onChanged: (bool val) {
//                         itemChange(val, i);
//                       },
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return Loading1();
//           }
//         },
//       ),
//     );
//   }
// }

// Future<List<CheckBoxListTileModel>> downloadJSON() async {
//   final jsonEndpoint = "https://mychoir2.000webhostapp.com";
//   final response = await get(Uri.parse(jsonEndpoint));

//   if (response.statusCode == 200) {
//     List pics = json.decode(response.body);
//     return pics.map((pic) => new CheckBoxListTileModel.fromJson(pic)).toList();
//   } else {
//     throw Exception('Unable to download images');
//   }
// }

// class CheckBoxListTileModel {
//   int userId;
//   String street;
//   int resNo;
//   String name;
//   String phone;
//   String latlong;
//   DateTime time;
//   bool isCheck;

//   CheckBoxListTileModel(
//       {this.userId,
//       this.street,
//       this.resNo,
//       this.isCheck,
//       this.phone,
//       this.latlong,
//       this.time,
//       this.name});

//   // Future<List> getData() async {
//   //   final responce = await http.get(Uri.parse(
//   //       "https://mychoir2.000webhostapp.com/cityClean/getRegisterers.php"));

//   //   var dat = json.decode(responce.body);
//   //   return dat;

//   //   // Showing Alert Dialog with Response JSON Message.
//   // }

//   factory CheckBoxListTileModel.fromJson(Map<String, dynamic> jsonData) {
//     return CheckBoxListTileModel(
//         name: jsonData['fname'],
//         street: jsonData['street'],
//         resNo: jsonData['resiNo'],
//         phone: jsonData['phone'],
//         latlong: jsonData['latlong'],
//         time: jsonData['time'],
//         isCheck: jsonData['bool']);
//   }

//   static List<CheckBoxListTileModel> getLocation() {
//     return <CheckBoxListTileModel>[
//       CheckBoxListTileModel(
//           userId: 1,
          
//           isCheck: false),
//       CheckBoxListTileModel(
//           userId: 2,
         
//           isCheck: false),
//       CheckBoxListTileModel(
//           userId: 3,
         
//           isCheck: false),
//       CheckBoxListTileModel(
//           userId: 4,
        
//           isCheck: false),
//       CheckBoxListTileModel(
//           userId: 5,
         
//           isCheck: false),
//     ];
//   }
// }
