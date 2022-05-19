import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SendServiceNotificationn extends StatefulWidget {
  @override
  _SendServiceNotificationnState createState() => _SendServiceNotificationnState();
}

class _SendServiceNotificationnState extends State<SendServiceNotificationn> {
  final formkey = GlobalKey<FormState>();
  bool saveAttempt = false;
  String selectedUser;

  TextEditingController title = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController recno = TextEditingController();
  TextEditingController time = TextEditingController();

  //inserting  to mysql
  sendNoti() async {
    var url =
        'https://mychoir2.000webhostapp.com/cityClean/serviceNotification.php';

    http.post(Uri.parse(url), body: {
      "title": "Service",
      "discription": discription.text,
      // "street": recno.text,
      // "time": time.text,
    });
  }

  bool _termsAgreed = false;

  @override
  Widget build(BuildContext context) {
    return 
       Container(
        alignment: Alignment.center,
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
                Colors.grey[800],
                //
              ]),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.0,
                ),
                CircleAvatar(
                    // backgroundImage: ExactAssetImage('assets/images/image1'),
                    backgroundColor: Color(0xFFFFFFFF),
                    radius: 50.0,
                    child: IconButton(
                      icon: Image.asset('lib/Assets/applogo.png'),
                      onPressed: () {},
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Send Service Notification",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  // ignore: deprecated_member_use
                  controller: discription,
                  // autovalidate: saveAttempt,
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  validator: (name) {
                    if (name.isEmpty) {
                      return 'Fill the description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    labelText: "Description",
                    hintText: 'Ex: Lipa sasa',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    focusColor: Colors.green[800],
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xFF40C00E),
                    )),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // TextFormField(
                //   controller: recno,
                //   // ignore: deprecated_member_use
                //   autovalidate: saveAttempt,

                //   validator: (emailValue) {
                //     if (emailValue.isEmpty) {
                //       return "Fill in Reciept No";
                //     }
                //   },
                //   decoration: InputDecoration(
                //     prefixIcon: Icon(Icons.email),
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.black45),
                //     ),
                //     labelText: "Reciept Number",
                //     hintText: 'Ex: 22g44388HHJ',
                //     hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                //     focusColor: Colors.green[400],
                //     focusedBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //       color: Color(0xFF2D793E),
                //     )),
                //   ),
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 18.0,
                //   ),
                // ),
              
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          saveAttempt = true;
                        });
                        if (formkey.currentState.validate()) {
                          formkey.currentState.save();
                          sendNoti();

                          Fluttertoast.showToast(
                              msg: "Sent",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              textColor: Colors.black);
                          // _register();
                          // _registered();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          'Send',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      );
    
  }
}
