import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:date_time_picker/date_time_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SendPaymentNotificationn extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<SendPaymentNotificationn> {
  final formkey = GlobalKey<FormState>();
  bool saveAttempt = false;
  String selectedUser;

  TextEditingController title = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController recno = TextEditingController();
  TextEditingController time = TextEditingController();

   DateTime _date = DateTime.parse("2021-07-20 20:10:04z");
   DateTime _datei = DateTime.parse("2021-05-20 20:10:04z");
   DateTime _datel = DateTime.parse("2022-05-20 20:10:04z");

  void _selectTime() async {
    final DateTime newTime = await showDatePicker(
      context: context,
      firstDate: _datei, initialDate: _date, lastDate: _datel,
    );
    if (newTime != null) {
      setState(() {
        _date = newTime;
      });
    }
  }

  //inserting  to mysql
  sendNoti() async {
    var url =
        'https://mychoir2.000webhostapp.com/cityClean/sendNotification.php';

    http.post(Uri.parse(url), body: {
      "username": selectedUser,
      "title": "Payment",
      "discription": discription.text,
      "reNo": recno.text,
      "time": _date.toString(),
    });
  }


  Future<List> getData2() async {
    final responce =
        await http.get(Uri.parse("https://mychoir2.000webhostapp.com/cityClean/getReg.php"));
    return json.decode(responce.body);
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
                Colors.green,
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
                  "Send Payment Notification",
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

                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: FutureBuilder<List>(
                        future: getData2(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DropdownButton(
                              
                              dropdownColor: Colors.white,
                              hint: Text("Names"),
                              value: selectedUser,
                              onChanged: (value) {
                                setState(() {
                                  this.selectedUser = value;
                                  print(this.selectedUser);
                                });
                              },
                              items: snapshot.data.map((winnie) {
                                return DropdownMenuItem(
                                  value: winnie['fname'],
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        winnie['fname'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        winnie['lname'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        })),

                
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  // ignore: deprecated_member_use
                  controller: discription,
                  autovalidate: saveAttempt,

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
                Column(
                  children: [
                    TextButton(onPressed: (){
                    _selectTime();
                    }, child: Text(
                      'Get Date'
                    )),

                    SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Selected Date: ${_date.day}',
                ),
                Text(
                  ' ${_date.month}',
                ),
                Text(
                  ' ${_date.year}',
                ),
                Text(
                  ' | ',
                ),
                Text(
                  ' ${_date.hour}',
                ),
                Text(
                  ':',
                ),
                Text(
                  ' ${_date.minute}',
                ),
              ],
            ),
                  ],
                ),
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
