import 'dart:async';
import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cleancityapp2/Modules/manager.dart';
import 'package:cleancityapp2/Modules/officer.dart';
import 'package:cleancityapp2/Modules/user.dart';
import 'package:cleancityapp2/home.dart';
import 'package:cleancityapp2/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'Modules/driver.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //awaits
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var position;
  var name;

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => Home(),
        '/Manager': (BuildContext context) => Manager(
            // position: position,
            //   name: name,
            ),
        '/Officer': (BuildContext context) => Officer(
              position: position,
              name: name,
            ),
        '/Driver': (BuildContext context) => Driver(),
        '/Users': (BuildContext context) => Users(
            // position: position,
            //   name2: name,
            ),
        '/Login': (BuildContext context) => Login(),
        // '/SignIn': (BuildContext context) => SignIn(),
        // '/SignUp': (BuildContext context) => SignUp(),
        // // '/': (BuildContext context) => QrCode(),
        // '/Tickets': (BuildContext context) => QrCode(),
      },
      debugShowCheckedModeBanner: false,
      title: 'CleaCity App',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.green[800],
          canvasColor: Colors.transparent),
      home: MyHomePage(title: 'CleanCity App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/applogo',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });

    showNotification();

    //Send tocket to firebase
    _saveDeviceTokenog();

    // _fbm.configure(
    //       onMessage: (Map<String, dynamic> message) async {
    //         print("onMessage: $message");
    //         showDialog(
    //             context: context,
    //             builder: (context) => AlertDialog(
    //                     content: ListTile(
    //                     title: Text(message['notification']['title']),
    //                     subtitle: Text(message['notification']['body']),
    //                     ),
    //                     actions: <Widget>[
    //                     FlatButton(
    //                         child: Text('Ok'),
    //                         onPressed: () => Navigator.of(context).pop(),
    //                     ),
    //                 ],
    //             ),
    //         );
    //     },
    //     onLaunch: (Map<String, dynamic> message) async {
    //         print("onLaunch: $message");
    //         // TODO optional
    //     },
    //     onResume: (Map<String, dynamic> message) async {
    //         print("onResume: $message");
    //         // TODO optional
    //     },
    //   );
  }

  int _counter = 0;
  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "CityClean",
        "Karibu tutengeneze dunia yetu!",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  _saveDeviceToken() async {
    // Get the current user
    String uid = 'jeffd23';
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fbm.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens =
          _db.collection('users').doc(uid).collection('tokens').doc(fcmToken);

      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }

  _saveDeviceTokenog() async {
    String uid = 'mushi';

    String fcmToken = await _fbm.getToken();

    // Save it to Firestore00
    if (fcmToken != null) {
      var tokens = _db.collection('tokens').doc(fcmToken);

      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }

  //Sennding tckens to firebase

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fbm = FirebaseMessaging.instance;
  StreamSubscription iosSubscription;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.white,
      splash: "lib/Assets/logo.gif",
      duration: 3000,
      splashIconSize: 500,
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: Login(),
    );
  }
}
