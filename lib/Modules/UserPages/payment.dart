import 'dart:convert';

import 'package:cleancityapp2/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Payments extends StatefulWidget {
  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  TextEditingController reciptNo = TextEditingController();
  TextEditingController paycontrol = TextEditingController();

  _recordPayment() async {
    var url = 'https://mychoir2.000webhostapp.com/cityClean/recordRecipts.php';

    http.post(Uri.parse(url), body: {
      "fname": name2,
      "lname": name,
      "email": email2,
      "recieptNo": reciptNo.text,
    });
  }

  _editMethod() async {
    var url = 'https://mychoir2.000webhostapp.com/cityClean/updatepayment.php';
    http.post(Uri.parse(url), body: {
      "Mid": idu,
      "pay": "yes",
    });
  }

  _dialogTigo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: SingleChildScrollView(
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "TigoPesa Menu",
                  style: TextStyle(
                      color: Colors.yellow[600],
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 220,
                ),
                Text(
                  "1. Enter Menu (*150*01#)",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "2. Select 5 (Lipa kwa Simu)",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "3. Select 1 (by Tigo Pesa)",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "4. Enter Merchant number '13432'",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "5. Enter Amount to be paid 10000",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "6. Enter PIN to complete payment.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 140,
                ),
                SizedBox(
                  width: 320.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _dialogMpesa() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: SingleChildScrollView(
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Mpesa Menu",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 220,
                ),
                Text(
                  "1. Dial *150*00#",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "2. Select Pay by phone",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "3. Enter Lipa number " '13432' "",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "4. Enter amount in Tshs 10000",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "5. Enter M-Pesa pin",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Align(
                  alignment: Alignment.center,
                                child: Container(
                                  width: 400,
                                  child: Text(
                    "6. You receive a confirmation SMS.",
                    maxLines: 2,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                                ),
                ),
                SizedBox(
                  height: 140,
                ),
                SizedBox(
                  width: 320.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: reciptNo,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Your Receipt Number'),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: RaisedButton(
                        onPressed: () {
                          _editMethod();
                          _recordPayment();
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Text(
                          "Send",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.send),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      _dialogMpesa();
                    },
                    child: Card(
                      child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage('lib/Assets/mpes.png')),
                    ),
                  ),
                  height: 160,
                  color: Colors.red,
                ),
              ),

              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 160,
                  color: Colors.blue,
                  child: GestureDetector(
                    onTap: () {
                      _dialogTigo();
                    },
                    child: Card(
                      child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage('lib/Assets/tigo.png')),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
