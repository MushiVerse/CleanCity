import 'dart:convert';
import 'package:cleancityapp2/Loadings/loading.dart';
import 'package:cleancityapp2/Modules/ManagerPages/Reports/attendenceRep.dart';
import 'package:cleancityapp2/Modules/manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Report extends StatefulWidget {
  const Report({Key key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List<Addcharts> fromJson(String strJsn) {
    final data = jsonDecode(strJsn);
    return List<Addcharts>.from(data.map((i) => Addcharts.fromMap(i)));
  }

  List<Addcharts> chartss = [];
  Future<List<Addcharts>> getdata() async {
    List<Addcharts> list = [];
    final res = await http.get(Uri.parse(
        "https://mychoir2.000webhostapp.com/cityClean/getRoutes.php"));
    if (res.statusCode == 200) {
      list = fromJson(res.body);
    }
    return list;
  }

  static List<charts.Series<Addcharts, String>> chartData(
      List<Addcharts> data) {
    return [
      charts.Series<Addcharts, String>(
          id: "DailyGabbage Collection",
          domainFn: (Addcharts d, _) => d.date,
          measureFn: (Addcharts d, _) => d.value,
          data: data)
    ];
  }

  @override
  void initState() {
    getdata().then((value) => chartss = value);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.replay_outlined),
                onPressed: () {
                  //     getdata();
                  chartData(chartss);
                })
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Text(
                    'Report',
                    style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                height: 140,
                color: Colors.yellow,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Attendance()));
                    },
                    tileColor: Colors.green[700],
                    title: Text('Attendance Report'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Manager()));
                    },
                    tileColor: Colors.green[700],
                    title: Text('Exit'),
                  ),
                ),
              )
            ],
          ),
        ),
        body: FutureBuilder(
            future: getdata(),
            builder: (cxt, snap) {
              return Card(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: chartData(chartss) == null
                      ? Loading()
                      : charts.BarChart(
                          chartData(chartss),
                          animate: true,
                        ),
                ),
              );
            }));
  }
}

class Addcharts {
  final String date;
  final int value;
  Addcharts({this.date, this.value});

  factory Addcharts.fromMap(Map<String, dynamic> map) {
    return Addcharts(
        date: map["time"], value: int.parse(map["booli"].length.toString()));
  }
}
