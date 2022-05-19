import 'package:cleancityapp2/Loadings/loading1.dart';
import 'package:cleancityapp2/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:wc_form_validators/wc_form_validators.dart';

class Registration extends StatefulWidget {
  Registration({key, this.appBar}) : super(key: key);

  final AppBar appBar;

  @override
  _RegisrationState createState() => _RegisrationState();
}

class _RegisrationState extends State<Registration> {
  final formkey = GlobalKey<FormState>();
  String email, password, cpassword, location, street, resiNo, phone, name;
  bool saveAttempt = false;
  String selectedlocolage;

  TextEditingController fnamecontrol = TextEditingController();
  TextEditingController lnamecontrol = TextEditingController();
  TextEditingController emailcontrol = TextEditingController();
  TextEditingController phonecontrol = TextEditingController();
  TextEditingController psswdcontrol = TextEditingController();
  TextEditingController latlngcontrol = TextEditingController();
  TextEditingController streetcontrol = TextEditingController();
  TextEditingController resiNocontrol = TextEditingController();

  Position _currentPosition;

  String _currentAddress;

  var selectedUser;

  //inserting  to mysql
  Future insertMethod() async {
    var url = 'https://unremembered-disadv.000webhostapp.com/register.php';
    http.post(Uri.parse(url), body: {
      "fname": fnamecontrol.text,
      "lname": lnamecontrol.text,
      "email": emailcontrol.text,
      "password": psswdcontrol.text,
      "phone": phonecontrol.text,
      "role": "user",
      
      // "latlng": latlngcontrol.text,
      "street": selectedUser,
      "resiNo": resiNocontrol.text,
      "pay": "no",
      "bool": "false",
    });
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  bool _termsAgreed = false;

  @override
  Widget build(BuildContext context) {
    String street = _currentAddress;
    streetcontrol.text = _currentAddress;

    try {
      // if (_currentPosition != null) {
      streetcontrol.text = _currentAddress;
      latlngcontrol.text =
          "${_currentPosition.longitude},${_currentPosition.longitude}";
      // } else {

      // }
    } catch (e) {
      // return Loading1();
      print(e);
    }

    return Scaffold(
      appBar: widget.appBar,
      body: Container(
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
                  "HAVE YOURSELF REGISTERED",
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
                  keyboardType: TextInputType.name,
                  // ignore: deprecated_member_use
                  controller: fnamecontrol,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                     inputFormatters: [
                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                  ],

                  validator: (name) {
                    if (name.isEmpty) {
                      return 'Fill in your First name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    labelText: "First Name",
                    hintText: 'Ex: Joshua Masanguda',
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

                TextFormField(
                  keyboardType: TextInputType.name,
                  // ignore: deprecated_member_use
                  controller: lnamecontrol,
                     inputFormatters: [
                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  validator: (name) {
                    if (name.isEmpty) {
                      return 'Fill in your Surname';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    labelText: "Last Name",
                    hintText: 'Ex: Joshua Masanguda',
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
                TextFormField(
                  controller: emailcontrol,
                  // ignore: deprecated_member_use
                     inputFormatters: [
                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,

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
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    labelText: "Email",
                    hintText: 'Ex: example@example.com',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    focusColor: Colors.green[400],
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xFF0EC035),
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

                TextFormField(
                  controller: phonecontrol,
                  // ignore: deprecated_member_use
                  
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  maxLength: 10,
                  validator: (phonval) {
                    if (phonval.isEmpty) {
                      return 'Fill in your phone number';
                    } else if (phonval.length < 10) {
                      return 'Invalid Length';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    labelText: "Phone",
                    hintText: 'Ex: 0756...',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    focusColor: Colors.orange,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xFFC0820E),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // if (_currentAddress != null) Text(
                      //   _currentAddress
                      // ),
                      // CircularProgressIndicator()
                      // ,


                      DropdownButton(
                              
                              dropdownColor: Colors.white,
                              hint: Text("Select your Street"),
                              value: selectedUser,
                              onChanged: (value) {
                                setState(() {
                                  this.selectedUser = value;
                                  print(this.selectedUser);
                                });
                              },
                              items: <String>['Makulu', 'UDOM', 'Dodoma Urban', 'Kikuyu'].map((winnie) {
                                return DropdownMenuItem(
                                  value: winnie,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        winnie,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            
                     
                     
                    ]),

                // TextFormField(
                //   controller: latlngcontrol,
                //   // ignore: deprecated_member_use
                //   autovalidateMode: saveAttempt,
                //   readOnly: true,

                //   validator: (sValue) {
                //     if (sValue.isEmpty) {
                //       return "Please wait, The Street is Loading...";
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.black45),
                //     ),
                //     hintText: 'Your Latitudes and Longitudes',
                //     prefixIcon: Icon(Icons.location_on_outlined),
                //     labelText:
                //         'Press the "Get location" button to generate your location',
                //     hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                //     focusColor: Colors.orange,
                //     focusedBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //       color: Color(0xFFC0820E),
                //     )),
                //   ),
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 18.0,
                //   ),
                // ),

                SizedBox(
                  height: 20.0,
                ),

                TextFormField(
                  controller: resiNocontrol,
                  // ignore: deprecated_member_use
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                     inputFormatters: [
                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                  ],

                  validator: (rValue) {
                    if (rValue.isEmpty) {
                      return "Fill your resident Nummber Ex: x-a40";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    hintText: 'Residence Number',
                    prefixIcon: Icon(Icons.location_city_outlined),
                    labelText: 'Residence No',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    focusColor: Colors.orange,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xFFC0820E),
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
                //
                //
                //
                //
                TextFormField(
                  controller: psswdcontrol,
                  obscureText: true,
                  // ignore: deprecated_member_use
                     inputFormatters: [
                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (passwdValue) {
                    setState(() {
                      password = passwdValue;
                    });
                  },
                  validator: Validators.compose([
                    Validators.required('Password required'),
                    // Validators.patternString(
                    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~+]).{8,}$',
                    //     'Invalid Password Format')

                            Validators.patternString(
                        r'^.{6,}$', 'Should be atlest 6 character long'),
                  ]),

                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    prefixIcon: Icon(Icons.security),
                    hoverColor: Colors.orange,
                    hintText: 'Enter Password',
                    labelText: 'Password',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    focusColor: Colors.orange,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xFFC0820E),
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
                //
                //
                //
                //
                TextFormField(
                  obscureText: true,
                  // ignore: deprecated_member_use
                     inputFormatters: [
                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  validator: (cPwdValue) {
                    if (cPwdValue != password) {
                      return "Passwords must match";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(Icons.security_rounded),
                    labelText: 'Re-Enter Password',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    focusColor: Colors.orange,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xFFC0820E),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                        value: _termsAgreed,
                        onChanged: (checkedValue) {
                          setState(() {
                            _termsAgreed = true;
                          });
                          _termsAgreed = checkedValue;
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Agreed to Terms & Conditions',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => new Login()));
                        },
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(
                      width: 50.0,
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          saveAttempt = true;
                        });
                        if (formkey.currentState.validate()) {
                          formkey.currentState.save();

                          await insertMethod().then((vale){
                            Fluttertoast.showToast(
                              msg: "Registered",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              textColor: Colors.black);

                          });

                          
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
                          'Register',
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
      ),
    );
  }
}
