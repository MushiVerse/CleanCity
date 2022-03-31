import 'dart:convert';
import 'package:cleancityapp2/Loadings/loading1.dart';
import 'package:cleancityapp2/Modules/ManagerPages/Reports/report.dart';
import 'package:http/http.dart' as http;
import 'package:cleancityapp2/Loadings/loading.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
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

  Future<List> getReport() async {
    final responce = await http.get(Uri.parse(
        "https://mychoir2.000webhostapp.com/cityClean/getReport.php"));

    var dat = json.decode(responce.body);
    return dat;

    // Showing Alert Dialog with Response JSON Message.
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

  _dialogReport() {}

  @override
  Widget build(BuildContext context) {
    body:
    // return Report();
    return Stack(
      children: [
        Container(
          height: 220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)),
              gradient: LinearGradient(
                  colors: [Colors.green, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: FutureBuilder(
                              future: getReport(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                    return ExpansionTile(
                                        title: Row(
                                          children: [
                                            Text(snapshot.data[index]['fname']),
                                            SizedBox(width: 10,),
                                            Text(snapshot.data[index]['lname']),
                                          ],
                                        ),
                                        subtitle: Text(snapshot.data[index]['time']),
                                        children: [
                                          Container(
                                            width: 400,
                                            child: Text(
                                              snapshot.data[index]['report'],
                                              maxLines: 100,
                                              overflow: TextOverflow.ellipsis,
                                              
                                            ),
                                          )
                                        ],
                                        );
                                  });
                                } else {
                                  return Loading1();
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      "Short Report from manager",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 70.0),
                      child: FutureBuilder(
                          future: getdata(),
                          builder: (cxt, snap) {
                            return Container(
                              height: 240,
                              color: Colors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    //  Reports(),
                                    chartData(chartss) == null
                                        ? Loading()
                                        : charts.BarChart(
                                            chartData(chartss),
                                            animate: true,
                                          ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
