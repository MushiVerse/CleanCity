import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final formkey = GlobalKey<FormState>();
  bool saveAttempt = false;
  String selectedUser;

  TextEditingController namecontrol = TextEditingController();
  TextEditingController emailcontrol = TextEditingController();
  TextEditingController phonecontrol = TextEditingController();
  TextEditingController psswdcontrol = TextEditingController();
  TextEditingController streetcontrol = TextEditingController();
  TextEditingController resiNocontrol = TextEditingController();
  TextEditingController lnamecontrol = TextEditingController();


  Future<List> getData2() async {
    final responce =
        await http.get(Uri.parse("https://mychoir2.000webhostapp.com/cityClean/getPositions.php"));
    return json.decode(responce.body);
  }
  //inserting  to mysql
  RegisteUsa() async {
    var url = 'https://mychoir2.000webhostapp.com/cityClean/registerOccupants.php';

    http.post(Uri.parse(url), body: {
      "fname": namecontrol.text,
      "lname": lnamecontrol.text,
      "email": emailcontrol.text,
      "position": selectedUser,
      "phone": phonecontrol.text,
      "password": lnamecontrol.text,
   
    });
  }

  bool _termsAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  "Register Occupants",
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
                  controller: namecontrol,
                  autovalidate: saveAttempt,

                  validator: (name) {
                    if (name.isEmpty) {
                      return 'Fill in your name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    labelText: "Full Name",
                    hintText: 'Ex: Josh',
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
                  // ignore: deprecated_member_use
                  controller: lnamecontrol,
                  autovalidate: saveAttempt,

                  validator: (name) {
                    if (name.isEmpty) {
                      return 'Fill in your Lastname';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    labelText: "Last Name",
                    hintText: 'Ex: Masanguda',
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
                  autovalidate: saveAttempt,

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
                  autovalidate: saveAttempt,

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

                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: FutureBuilder<List>(
                        future: getData2(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DropdownButton(
                              
                              dropdownColor: Colors.white,
                              hint: Text("Position"),
                              value: selectedUser,
                              onChanged: (value) {
                                setState(() {
                                  this.selectedUser = value;
                                  print(this.selectedUser);
                                });
                              },
                              items: snapshot.data.map((winnie) {
                                return DropdownMenuItem(
                                  value: winnie['position'],
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        winnie['position'],
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
                          RegisteUsa();

                          Fluttertoast.showToast(
                              msg: "Registered",
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
