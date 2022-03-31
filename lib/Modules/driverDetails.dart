import 'package:cleancityapp2/Loadings/loading.dart';
import 'package:cleancityapp2/Loadings/loading1.dart';
import 'package:cleancityapp2/Modules/DriverPages/GmapPage.dart';
import 'package:cleancityapp2/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// final availableMaps = await MapLauncher.installedMaps;
// print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

// await availableMaps.first.showMarker(
//   coords: Coords(37.759392, -122.5107336),
//   title: "Ocean Beach",
// );

class DriverDetails extends StatefulWidget {
  final String name, position;
  final bool booliy;
  final int index;
  final List post;

  AsyncSnapshot<dynamic> snapshot;
  DriverDetails({
    this.name,
    this.position,
    this.booliy,
    this.snapshot,
    this.index,
    this.post,
  });

  @override
  _DriverState createState() => _DriverState();
}

class _DriverState extends State<DriverDetails> {
  bool loading;
  bool bol = false;

  // String fname;
  String lname = '';
  String email = '';
  //
  String fnamee;
  TextEditingController fn = new TextEditingController();

  int index;
  TextEditingController fnameco;

  _statusing() async {
    var url = 'https://mychoir2.000webhostapp.com/cityClean/routeStatus.php';

    http.post(Uri.parse(url), body: {
      "fname": name2,
      "lname": name,
      "cname": widget.post[widget.index]['fname'],
      "email": email2,
      "booli": _isChecked[0].toString(),
    });
  }

  _gmap() async {
//     final availableMaps = await MapLauncher.installedMaps;
// print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

// await availableMaps.first.showMarker(
//   coords: Coords(37.759392, -122.5107336),
//   title: "Ocean Beach",
// );

    if (await MapLauncher.isMapAvailable(MapType.google)) {
      await MapLauncher.showMarker(
        mapType: MapType.google,
        coords: Coords(-6.369028, 34.888822),
        title: "Udom",
        description: "Chuo Kikuu cha Dodoma",
      );
    }
  }

  Future<List> getData() async {
    final responce = await http.get(Uri.parse(
        "https://mychoir2.000webhostapp.com/cityClean/getRegisterers.php"));

    var dat = json.decode(responce.body);
    // return dat;

    if (dat.length == 1) {
      setState(() {
        fname = dat[0]['fname'];
        lname = dat[0]['lname'];
        email = dat[0]['email'];
      });
    }
    // print(fname);
    return dat;

    // Showing Alert Dialog with Response JSON Message.
  }

  List<bool> _isChecked;

  @override
  void initState() {
    _statusing();
    getData();
    // _editMethod();
    _isChecked = List<bool>.filled(100, false);

    // fnameco = widget.list[widget.ind]['fname'];
    // print(_isChecked);
    print(fnamee.toString());
  }

  // _editMethod() async {
  //   var url = 'https://mychoir2.000webhostapp.com/cityClean/updatepayment.php';
  //   http.post(Uri.parse(url), body: {
  //     "Mid": id,
  //     "bool": _isChecked[0].toString(),
  //   });
  // }

  bool _isSelected = false;

  // GoogleMapController _googleMapController;

  // Marker _origin;

  // Marker _destination;

  @override
  Widget build(BuildContext context) {
    String name2;
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0,
        leading: Text("$name"),
        // IconButton(

        //   icon: Icon(
        //   Icons.person
        // ), onPressed: (){}),
        backgroundColor: Colors.green[700],
        // title: Text(
        //   "Transport Status",
        //   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        //   ),

        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.green[800],
            itemBuilder: (BuildContext bc) => [
              PopupMenuItem(
                  child: Text(
                    "Share",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  value: ""),
              PopupMenuItem(
                child: Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: "/new-group-chat",
              ),
              PopupMenuItem(
                  child: Text(
                    "LogOut",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  value: "/Login"),
            ],
            onSelected: (route) {
              print(route);
              Navigator.pushNamed(context, route);
            },
          ),
        ],

        title: new Text('ToDo Details'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading1();
          } else {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                String boolAsString;
                dynamic bolval = _isChecked[index];

                bool b = boolAsString == snapshot.data[index]['bool'];
                // print(b);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: new Card(
                    shadowColor: Colors.greenAccent,
                    elevation: 10,
                    color: Colors.white,
                    child: new Container(
                      padding: new EdgeInsets.all(10.0),
                      child: Container(
                        height: 270,
                        child: Center(
                          child: ExpansionTile(
                            title: new CheckboxListTile(
                                activeColor: Colors.green[300],
                                dense: true,
                                //font change
                                title: Text(widget.post[widget.index]['fname']),
                                subtitle: Text(
                                    // snapshot.data[index]['latlng'],
                                    widget.post[widget.index]['street']),
                                value: _isChecked[index],
                                onChanged: (bool val) {
                                  // itemChange(val, index);

                                  setState(() {
                                    _isChecked[index] = val;
                                    _statusing();
                                  });
                                }),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green),
                                      onPressed: () {
                                        _gmap();
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) => GMap()));
                                      },
                                      child: Text('Get Location'))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
