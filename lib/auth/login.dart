// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:cleancityapp2/Loadings/loading.dart';
// import 'package:cleancityapp2/Modules/driver.dart';
// import 'package:cleancityapp2/Modules/driverDetails.dart';
// import 'package:cleancityapp2/Modules/manager.dart';
// import 'package:cleancityapp2/Modules/officer.dart';
// import 'package:cleancityapp2/Modules/user.dart';
// import 'package:cleancityapp2/auth/registration.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'dart:core';
// import 'package:wc_form_validators/wc_form_validators.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:wc_form_validators/wc_form_validators.dart';

// String name = '';
// String name2 = '';
// String position = '';
// String email2 = '';
// String fname = "";
// String jina = "";
// dynamic idu = '';
// bool booliy, booliy1, booliy2;

// class Login extends StatefulWidget {
//   final AppBar appBar;
//   List list;
//   int index;
//   Login({key, this.appBar, this.index, this.list}) : super(key: key);
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   bool loading = false;
//   bool _obscureText = true;
//   //firebase
//   String email, password, msg;

//   String boolAsString;

//   List<int> i = [0, 1, 2, 4, 5, 6, 7, 8];
//   //Map<String, dynamic> ind = [{0} , {1} , {2} ,{3}] as Map<String, dynamic>;

//   // final FirebaseFirestore _fbfs = FirebaseFirestore.instance;
//   // final FirebaseMessaging _fbm = FirebaseMessaging();
//   // StreamSubscription iosSubscription;

//   // @override
//   // void initState() {
//   //   super.initState();

//   //   // permisions
//   //   if (Platform.isIOS) {
//   //     iosSubscription = _fbm.onIosSettingsRegistered.listen((data) {
//   //       // save the token  OR subscribe to a topic here
//   //     });

//   //     _fbm.requestNotificationPermissions(IosNotificationSettings());
//   //   } else {
//   //     return null;
//   //   }

//   //   // _saveDeviceToken();

//   //   _fbm.configure(onMessage: (Map<String, dynamic> message) async {
//   //     print('onMessage: $message');

//   //     final snackb = SnackBar(
//   //       content: Text(message['notification']['title']),
//   //       action: SnackBarAction(
//   //         label: 'Go',
//   //         onPressed: () => null,
//   //       ),
//   //     );

//   //     Scaffold.of(context).showSnackBar(snackb);
//   //   }, onLaunch: (Map<String, dynamic> message) async {
//   //     print('onLaunch: $message');
//   //   }, onResume: (Map<String, dynamic> message) async {
//   //     print('onResume: $message');
//   //   });

//   //   _fbm.configure(
//   //     onMessage: (Map<String, dynamic> message) async {
//   //       print("onMessage: $message");
//   //       showDialog(
//   //         context: context,
//   //         builder: (context) => AlertDialog(
//   //           content: ListTile(
//   //             title: Text(message['notification']['title']),
//   //             subtitle: Text(message['notification']['body']),
//   //           ),
//   //           actions: <Widget>[
//   //             FlatButton(
//   //               child: Text('Ok'),
//   //               onPressed: () => Navigator.of(context).pop(),
//   //             ),
//   //           ],
//   //         ),
//   //       );
//   //     },
//   //     onLaunch: (Map<String, dynamic> message) async {
//   //       print("onLaunch: $message");
//   //       // TODO optional
//   //     },
//   //     onResume: (Map<String, dynamic> message) async {
//   //       print("onResume: $message");
//   //       // TODO optional
//   //     },
//   //   );
//   // }

//   // _saveDeviceToken() async {
//   //   // Get the current user
//   //   String uid = 'jeffd23';
//   //   // FirebaseUser user = await _auth.currentUser();

//   //   // Get the token for this device
//   //   String fcmToken = await _fbm.getToken();

//   //   // Save it to Firestore
//   //   if (fcmToken != null) {
//   //     var tokens =
//   //         _fbfs.collection('users').doc(uid).collection('tokens').doc(fcmToken);

//   //     await tokens.set({
//   //       'token': fcmToken,
//   //       'createdAt': FieldValue.serverTimestamp(), // optional
//   //       'platform': Platform.operatingSystem // optional
//   //     });
//   //   }
//   // }

//   Future<List> _login() async {
//     final response = await http.post(
//         Uri.parse(
//             "https://mychoir2.000webhostapp.com/cityClean/getOccupant.php"),
//         body: {
//           "email": user.text,
//           "password": pass.text,
//         });

//     final response2 = await http.post(
//         Uri.parse("https://mychoir2.000webhostapp.com/cityClean/login.php"),
//         body: {
//           "email": user.text,
//           "password": pass.text,
//         });

//     final response3 = await http.post(
//         Uri.parse(
//             "https://mychoir2.000webhostapp.com/cityClean/getRegisterers.php"),
//         body: {
//           "email": user.text,
//           "password": pass.text,
//         });

//     var datauser = json.decode(response.body);
//     var datauser2 = json.decode(response2.body);
//     var datauser3 = json.decode(response3.body);

//     if (datauser2.length == 1) {
//       Navigator.pushReplacementNamed(context, '/Users');
//       setState(() {
//         name2 = datauser2[0]['fname'];
//         name = datauser2[0]['lname'];
//         position = datauser2[0]['position'];
//         email2 = datauser2[0]['email'];
//         idu = datauser2[0]['id'];
//         // booliy = datauser2[0]['bool'];
//         // booliy = boolAsString == datauser2[0]['bool'];
//       });
//     } else if (datauser.length == 0) {
//       setState(() => loading = true);

//       setState(() {
//         displayDialog();
//       });

//       setState(() => loading = false);
//     } else {
//       // Navigator.pushReplacementNamed(context, '/Users');

//       if (datauser[0]['position'] == 'manager') {
//         setState(() => loading = true);
//         print(datauser);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => Managing(
//                       position: position,
//                       name: name,
//                     )));
//         // Navigator.pop(context);
//       } else if (datauser[0]['position'] == 'officer') {
//         Navigator.pushReplacementNamed(context, '/Officer');
//       } else if (datauser[0]['position'] == 'driver') {
//         // Navigator.pushReplacementNamed(context, '/Driver');
//         Navigator.of(context).push(new MaterialPageRoute(
//           builder: (BuildContext context) => Driver(),
//         ));
//       }

//       setState(() {
//         name2 = datauser[0]['fname'];
//         name = datauser[0]['lname'];
//         position = datauser[0]['position'];
//         email = datauser[0]['email'];
//         fname = datauser3[0]['fname'];
//         booliy = boolAsString == datauser3[0]['bool'];
//         jina = datauser3[0]['lname'];
//         // booliy1 = boolAsString == datauser3[1]['bool'];
//         //booliy2 = boolAsString == datauser3[2]['bool'];
//       });
//     }

//     return datauser;
//   }

//   //TextControllers
//   TextEditingController user = new TextEditingController();
//   TextEditingController pass = new TextEditingController();

//   //Password obsecure
//   void _toggle() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   //CupertinoAlertDialog

//   void displayDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => new CupertinoAlertDialog(
//         title: new Text("Habari"),
//         content: new Text("Incorrect username or password ,Try Again! "),
//         actions: [
//           CupertinoDialogAction(
//               isDefaultAction: true,
//               child: new TextButton(
//                 child: Text(
//                   "Sawa",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onPressed: () {
//                   Navigator.pushReplacementNamed(context, '/Login');
//                 },
//               ))
//         ],
//       ),
//     );
//   }

//   void clearText() {
//     user.clear();
//     pass.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return loading
//         ? Loading()
//         : Scaffold(
//             appBar: widget.appBar,
//             body: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     stops: [
//                       0.5,
//                       1.0,
//                     ],
//                     colors: [
//                       Color(0xFFFFFFFF),
//                       Colors.green[800]
//                       //
//                     ]),
//               ),
//               child: Form(
//                 child: Center(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         SizedBox(
//                           height: 30.0,
//                         ),
//                         CircleAvatar(
//                             // backgroundImage: ExactAssetImage('assets/images/image1'),
//                             backgroundColor: Color(0xFFFFFFFF),
//                             radius: 50.0,
//                             child: IconButton(
//                               icon: Image.asset('lib/Assets/applogo.png'),
//                               onPressed: () {},
//                             )),
//                         Stack(children: <Widget>[
//                           Text(
//                             'User login',
//                             style: TextStyle(
//                               fontSize: 30,
//                               foreground: Paint()
//                                 ..style = PaintingStyle.stroke
//                                 ..strokeWidth = 6
//                                 ..color = Colors.white,
//                             ),
//                           ),
//                           // Solid text as fill.
//                           Text(
//                             'User login',
//                             style: TextStyle(
//                               fontSize: 30,
//                               color: Color(0xFF3E2723),
//                             ),
//                           ),
//                         ]),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 16.0, horizontal: 16.0),
//                           child: Divider(),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 16.0, horizontal: 16.0),
//                           child: TextFormField(
//                             // onChanged: (textVal) {
//                             //   setState(() {
//                             //     email = textVal;
//                             //   });
//                             // },
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             validator: (emailValue) {
//                               if (emailValue.isEmpty) {
//                                 return "Fill in your email";
//                               }

//                               String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
//                                   "\\@" +
//                                   "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
//                                   "(" +
//                                   "\\." +
//                                   "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
//                                   ")+";

//                               RegExp regExp = new RegExp(p);

//                               if (regExp.hasMatch(emailValue)) {
//                                 return null;
//                               }

//                               return 'Invalid Email Format';
//                             },
//                             controller: user,
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(Icons.person),
//                               labelText: 'Email',
//                               hintText: 'Ex: example@example.com',
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: const BorderRadius.all(
//                                   const Radius.circular(50.0),
//                                 ),
//                                 borderSide: BorderSide(
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.green[400],
//                                 ),
//                                 borderRadius: const BorderRadius.all(
//                                   const Radius.circular(50.0),
//                                 ),
//                               ),
//                               filled: true,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 1.0, horizontal: 16.0),
//                           child: TextFormField(
//                             // onChanged: (textVal) {
//                             //   setState(() {
//                             //     password = textVal;
//                             //   });
//                             // },
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             validator: Validators.compose([
//                               Validators.required('Password required'),
//                               // Validators.patternString(
//                               //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
//                               //     'Invalif format')
//                             ]),
//                             obscureText: _obscureText,
//                             controller: pass,
//                             cursorColor: Colors.green[400],
//                             decoration: InputDecoration(
//                               helperText:
//                                   "Weka neno siri ulilo sajili kwa mfumo mwenza.",
//                               prefixIcon: Icon(Icons.security_rounded),
//                               labelText: 'Password',
//                               hintText: 'Enter Password',
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: const BorderRadius.all(
//                                   const Radius.circular(50.0),
//                                 ),
//                                 borderSide: BorderSide(color: Colors.black),
//                               ),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.green[400],
//                                 ),
//                                 borderRadius: const BorderRadius.all(
//                                   const Radius.circular(50.0),
//                                 ),
//                               ),
//                               filled: true,
//                             ),
//                           ),
//                         ),
//                         new TextButton(
//                             onPressed: _toggle,
//                             child: new Text(
//                               _obscureText ? "Show Password" : "Hide Password",
//                               style: TextStyle(color: Colors.black),
//                             )),
//                         Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 60.0, vertical: 25.0),
//                             child: ElevatedButton(
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.login,
//                                     color: Colors.black,
//                                   ),
//                                   Text('Manager')
//                                 ],
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 primary: Colors.green[400],
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0)),
//                               ),
//                               onPressed: () async {
//                                 setState(() => loading = true);
//                                 // displayDialog();
//                                 // setState(() => loading = false);

//                                 // _login();

//                                 // _saveDeviceToken();

//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => Manager()));
//                               },
//                             )),
//                             Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 60.0, vertical: 25.0),
//                             child: ElevatedButton(
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.login,
//                                     color: Colors.black,
//                                   ),
//                                   Text('Driver')
//                                 ],
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 primary: Colors.green[400],
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0)),
//                               ),
//                               onPressed: () async {
//                                 setState(() => loading = true);
//                                 // displayDialog();
//                                 // setState(() => loading = false);

//                                 // _login();

//                                 // _saveDeviceToken();

//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => Driver()));
//                               },
//                             )),
//                             Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 60.0, vertical: 25.0),
//                             child: ElevatedButton(
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.login,
//                                     color: Colors.black,
//                                   ),
//                                   Text('Officer')
//                                 ],
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 primary: Colors.green[400],
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0)),
//                               ),
//                               onPressed: () async {
//                                 setState(() => loading = true);
//                                 // displayDialog();
//                                 // setState(() => loading = false);

//                                 // _login();

//                                 // _saveDeviceToken();

//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => Officer()));
//                               },
//                             )),
//                             Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 60.0, vertical: 25.0),
//                             child: ElevatedButton(
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.login,
//                                     color: Colors.black,
//                                   ),
//                                   Text('User')
//                                 ],
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 primary: Colors.green[400],
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0)),
//                               ),
//                               onPressed: () async {
//                                 setState(() => loading = true);
//                                 // displayDialog();
//                                 // setState(() => loading = false);

//                                 // _login();

//                                 // _saveDeviceToken();

//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => Users()));
//                               },
//                             )),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 0.0, vertical: 25.0),
//                         ),
//                         Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 0.0, vertical: 25.0),
//                             child: ElevatedButton(
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   // IconButton(
//                                   //   // icon:Image.asset("lib/Assets/g1.jpg"),
//                                   //   // icon: Icon(Icons.person_search),
//                                   //   onPressed: () {  },
//                                   // ),
//                                   Text(
//                                     "Sign in with Google",
//                                     style: TextStyle(color: Colors.black87),
//                                   ),
//                                 ],
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 primary: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0)),
//                               ),
//                               onPressed: () async {
//                                 displayDialog();
//                               },
//                             )),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 16.0, horizontal: 16.0),
//                           child: Divider(),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "Don't have an account ? ",
//                               style: TextStyle(color: Colors.red, fontSize: 16),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).push(
//                                     new MaterialPageRoute(
//                                         builder: (BuildContext context) =>
//                                             Registration()));
//                               },
//                               child: Text(
//                                 "Have one!",
//                                 style: TextStyle(
//                                     color: Color(0xFF0B4E11),
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 10.0, vertical: 8.0),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ));
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cleancityapp2/Loadings/loading.dart';
import 'package:cleancityapp2/Modules/driver.dart';
import 'package:cleancityapp2/Modules/manager.dart';
import 'package:cleancityapp2/Modules/officer.dart';
import 'package:cleancityapp2/Modules/user.dart';
import 'package:cleancityapp2/auth/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:wc_form_validators/wc_form_validators.dart';
// import 'package:wc_form_validators/wc_form_validators.dart';

String name = '';
String name2 = '';
String position = '';
String email2 = '';
String fname = "";
String jina = "";
dynamic idu = '';
bool booliy, booliy1, booliy2;

class Login extends StatefulWidget {
  final AppBar appBar;
  List list;
  int index;
  Login({key, this.appBar, this.index, this.list}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  bool _obscureText = true;
  //firebase
  String email, password, msg;

  String boolAsString;

  List<int> i = [0, 1, 2, 4, 5, 6, 7, 8];

  bool saveAttempt = false;
  final formkey = GlobalKey<FormState>();
  //Map<String, dynamic> ind = [{0} , {1} , {2} ,{3}] as Map<String, dynamic>;

  // final FirebaseFirestore _fbfs = FirebaseFirestore.instance;
  // final FirebaseMessaging _fbm = FirebaseMessaging();
  // StreamSubscription iosSubscription;

  // @override
  // void initState() {
  //   super.initState();

  //   // permisions
  //   if (Platform.isIOS) {
  //     iosSubscription = _fbm.onIosSettingsRegistered.listen((data) {
  //       // save the token  OR subscribe to a topic here
  //     });

  //     _fbm.requestNotificationPermissions(IosNotificationSettings());
  //   } else {
  //     return null;
  //   }

  //   // _saveDeviceToken();

  //   _fbm.configure(onMessage: (Map<String, dynamic> message) async {
  //     print('onMessage: $message');

  //     final snackb = SnackBar(
  //       content: Text(message['notification']['title']),
  //       action: SnackBarAction(
  //         label: 'Go',
  //         onPressed: () => null,
  //       ),
  //     );

  //     Scaffold.of(context).showSnackBar(snackb);
  //   }, onLaunch: (Map<String, dynamic> message) async {
  //     print('onLaunch: $message');
  //   }, onResume: (Map<String, dynamic> message) async {
  //     print('onResume: $message');
  //   });

  //   _fbm.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print("onMessage: $message");
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           content: ListTile(
  //             title: Text(message['notification']['title']),
  //             subtitle: Text(message['notification']['body']),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text('Ok'),
  //               onPressed: () => Navigator.of(context).pop(),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //       // TODO optional
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: $message");
  //       // TODO optional
  //     },
  //   );
  // }

  // _saveDeviceToken() async {
  //   // Get the current user
  //   String uid = 'jeffd23';
  //   // FirebaseUser user = await _auth.currentUser();

  //   // Get the token for this device
  //   String fcmToken = await _fbm.getToken();

  //   // Save it to Firestore
  //   if (fcmToken != null) {
  //     var tokens =
  //         _fbfs.collection('users').doc(uid).collection('tokens').doc(fcmToken);

  //     await tokens.set({
  //       'token': fcmToken,
  //       'createdAt': FieldValue.serverTimestamp(), // optional
  //       'platform': Platform.operatingSystem // optional
  //     });
  //   }
  // }

  Future<List> _login() async {
    // final response = await http.post(
    //     Uri.parse(
    //         "https://mychoir2.000webhostapp.com/cityClean/getOccupant.php"),
    //     body: {
    //       "email": user.text,
    //       "password": pass.text,
    //     });

    final response2 = await http.post(
        Uri.parse("https://unremembered-disadv.000webhostapp.com/login.php"),
        body: {
          "username": user.text,
          "password": pass.text,
        });

    // final response3 = await http.post(
    //     Uri.parse(
    //         "https://mychoir2.000webhostapp.com/cityClean/getRegisterers.php"),
    //     body: {
    //       "email": user.text,
    //       "password": pass.text,
    //     });

    // var datauser = json.decode(response.body);
    var datauser2 = json.decode(response2.body);
    // var datauser3 = json.decode(response3.body);

    if (datauser2.length == 1) {
      // Navigator.pushReplacementNamed(context, '/Users');

      if (datauser2[0]['role'] == 'manager') {
        setState(() => loading = true);
        // print(datauser);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Managing(
                      position: position,
                      name: name,
                    )));
        // Navigator.pop(context);
      } else if (datauser2[0]['role'] == 'driver') {
        Navigator.pushReplacementNamed(context, '/Driver');
      } else if (datauser2[0]['role'] == 'officer') {
        Navigator.pushReplacementNamed(context, '/Officer');
      } else if (datauser2[0]['role'] == 'user') {
        // Navigator.pushReplacementNamed(context, '/Users');

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Users(
                      position: datauser2[0]['role'],
                      fname: datauser2[0]['fname'],
                      lname: datauser2[0]['lname'],
                    )));
      }
      // Navigator.pushReplacementNamed(context, '/Users');
      setState(() {
        // name2 = datauser2[0]['fname'];
        // name = datauser2[0]['lname'];
        // position = datauser2[0]['role'];
        // email2 = datauser2[0]['email'];
        // idu = datauser2[0]['id'];
        // booliy = datauser2[0]['bool'];
        // booliy = boolAsString == datauser2[0]['bool'];
      });
    } else if (datauser2.length == 0) {
      setState(() => loading = true);

      setState(() {
        displayDialog();
      });

      setState(() => loading = false);
    } else {
      // Navigator.pushReplacementNamed(context, '/Users');

      // else if (datauser[0]['position'] == 'driver') {
      //   // Navigator.pushReplacementNamed(context, '/Driver');
      //   Navigator.of(context).push(new MaterialPageRoute(
      //     builder: (BuildContext context) => Driver(),
      //   ));
      // }

      setState(() {
        // name2 = datauser[0]['fname'];
        // name = datauser[0]['lname'];
        // position = datauser[0]['position'];
        // email = datauser[0]['email'];
        // fname = datauser3[0]['fname'];
        // booliy = boolAsString == datauser3[0]['bool'];
        // jina = datauser3[0]['lname'];
        // booliy1 = boolAsString == datauser3[1]['bool'];
        //booliy2 = boolAsString == datauser3[2]['bool'];
      });
    }

    return datauser2;
  }

  //TextControllers
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  //Password obsecure
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //CupertinoAlertDialog

  void displayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Sorry"),
        content: new Text("Incorrect username or password ,Try Again! "),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoDialogAction(
                isDefaultAction: true,
                child: new TextButton(
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.pushReplacementNamed(context, '/Login');
                  },
                )),
          )
        ],
      ),
    );
  }

  void clearText() {
    user.clear();
    pass.clear();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: widget.appBar,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.5,
                      1.0,
                    ],
                    colors: [
                      Color(0xFFFFFFFF),
                      Colors.green[800]
                      //
                    ]),
              ),
              child: Form(
                key: formkey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        CircleAvatar(
                            // backgroundImage: ExactAssetImage('assets/images/image1'),
                            backgroundColor: Color(0xFFFFFFFF),
                            radius: 50.0,
                            child: IconButton(
                              icon: Image.asset('lib/Assets/applogo.png'),
                              onPressed: () {},
                            )),
                        Stack(children: <Widget>[
                          Text(
                            'User login',
                            style: TextStyle(
                              fontSize: 30,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = Colors.white,
                            ),
                          ),
                          // Solid text as fill.
                          Text(
                            'User login',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF3E2723),
                            ),
                          ),
                        ]),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: Divider(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: TextFormField(
                            // onChanged: (textVal) {
                            //   setState(() {
                            //     email = textVal;
                            //   });
                            // },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (emailValue) {
                              if (emailValue.isEmpty) {
                                return "Fill in your email";
                              }

                              String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                                  "\\@" +
                                  "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                                  "(" +
                                  "\\." +
                                  "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                                  ")+";

                              RegExp regExp = new RegExp(p);

                              if (regExp.hasMatch(emailValue)) {
                                return null;
                              }

                              return 'Invalid Email Format';
                            },
                            controller: user,
                               inputFormatters: [
                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                  ],
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Email',
                              hintText: 'Ex: example@example.com',
                              
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green[400],
                                ),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 16.0),
                          child: TextFormField(
                            // onChanged: (textVal) {
                            //   setState(() {
                            //     password = textVal;
                            //   });
                            // },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: Validators.compose([
                              Validators.required('Password required'),
                              // Validators.patternString(
                              //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                              //     'Invalif format')
                            ]),
                            obscureText: _obscureText,
                            controller: pass,
                            cursorColor: Colors.green[400],
                            decoration: InputDecoration(
                              helperText:
                                  "Usiruhusu mtu kuona taarifa hizi.",
                              prefixIcon: Icon(Icons.security_rounded),
                              labelText: 'Password',
                              hintText: 'Enter Password',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green[400],
                                ),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        new TextButton(
                            onPressed: _toggle,
                            child: new Text(
                              _obscureText ? "Show Password" : "Hide Password",
                              style: TextStyle(color: Colors.black),
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 60.0, vertical: 25.0),
                            child: ElevatedButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: Colors.black,
                                  ),
                                  Text('Login')
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[400],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              onPressed: () async {

                                 setState(() {
                          saveAttempt = true;
                        });
                        
                                if (formkey.currentState.validate()) {
                                  formkey.currentState.save();

                                  setState(() => loading = true);
                                // displayDialog();
                                setState(() => loading = false);

                                _login();
                                }
                                

                                // _saveDeviceToken();

                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => Manager()));
                              },
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 25.0),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 25.0),
                            child: ElevatedButton(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // IconButton(
                                  //   // icon:Image.asset("lib/Assets/g1.jpg"),
                                  //   // icon: Icon(Icons.person_search),
                                  //   onPressed: () {  },
                                  // ),
                                  Text(
                                    "Sign in with Google",
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              onPressed: () async {
                                displayDialog();
                              },
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: Divider(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ? ",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Registration()));
                              },
                              child: Text(
                                "Have one!",
                                style: TextStyle(
                                    color: Color(0xFF0B4E11),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
