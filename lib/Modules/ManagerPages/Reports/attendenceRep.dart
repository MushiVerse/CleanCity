import 'package:cleancityapp2/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Attendance extends StatefulWidget {
  const Attendance({Key key}) : super(key: key);

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  TextEditingController reportcontro = TextEditingController();
  _recordPayment() async {
    var url = 'https://mychoir2.000webhostapp.com/cityClean/recordReport.php';

    http.post(Uri.parse(url), body: {
      "fname": name2,
      "lname": name,
      "email": email2,
      "record": reportcontro.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [

            SizedBox(
              height: 50,
            ),
            Card(
              child: TextFormField(
                controller: reportcontro,
                minLines: 1,
                maxLines: 20,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: 'Write Report',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(60)))),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _recordPayment();
                },
                child: Text('Send Report'))
          ],
        ),
      ),
    );
  }
}
