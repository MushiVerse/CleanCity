// import 'dart:convert';

// import 'package:cleancityapp2/Loadings/loading1.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ViewReport extends StatefulWidget {
//   const ViewReport({Key key}) : super(key: key);

//   @override
//   _ViewReportState createState() => _ViewReportState();
// }

// class _ViewReportState extends State<ViewReport> {
//   Future<List> getReport() async {
//     final responce = await http.get(Uri.parse(
//         "https://mychoir2.000webhostapp.com/cityClean/getReport.php"));

//     var dat = json.decode(responce.body);
//     return dat;

//     // Showing Alert Dialog with Response JSON Message.
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: FutureBuilder(
//         future: getReport(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (context, index) {
//               return ExpansionTile(
//                 title: snapshot.data[index]['fname']);
//             });
//           } else {
//             return Loading1();
//           }
//         },
//       ),
//     );
//   }
// }
