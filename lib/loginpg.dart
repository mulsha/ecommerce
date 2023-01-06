import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/registerpg.dart';
import 'package:ecommerce/viewpage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class loginpg extends StatefulWidget {
  @override
  State<loginpg> createState() => _loginpgState();
}

class _loginpgState extends State<loginpg> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Postdata? tt;
  bool emaill = false;
  bool passs = false;
  String _errormsg = "";
  // bool logis = false;
  bool connection = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    double tht = MediaQuery.of(context).size.height;
    double tw = MediaQuery.of(context).size.width;
    double bottom = MediaQuery.of(context).padding.bottom;
    double top = MediaQuery.of(context).padding.top;
    double th = tht - bottom - top;

    return Scaffold(
      backgroundColor: const Color(0XFF00adbe),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                decoration: const BoxDecoration(
                    color: Color(0XFFededed),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 35),
                      // color: Colors.orange,
                      child: const Center(
                          child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                            color: Color(0XFF07a2b4)),
                      )),
                    ),
                    Container(
                      // color: Colors.orange,
                      margin: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                      child: TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            errorText: emaill ? "Please Enter Email" : null,
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email_outlined,
                                color: Color(0XFF009bb9)),
                            hintStyle: const TextStyle(
                                color: Color(0XFF009bb9),
                                fontSize: 16,
                                letterSpacing: 0.8)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 5, 15, 20),
                      child: TextFormField(
                        controller: password,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          validatedemail(value);
                        },
                        decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.remove_red_eye_outlined,
                              color: Color(0XFF009bb9),
                              size: 22,
                            ),
                            errorText: passs ? "Please Enter Password" : null,
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline_rounded,
                                color: Color(0XFF009bb9)),
                            hintStyle: const TextStyle(
                                color: const Color(0XFF009bb9),
                                fontSize: 16,
                                letterSpacing: 0.8)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 25),
                      child: const Center(
                          child: Text(
                        "Forgot your password ?",
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color(0XFF346174),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.7),
                      )),
                    ),
                    InkWell(
                      onTap: () async {
                        String useremail = email.text;
                        String userpass = password.text;

                        setState(() {
                          if (email.text.isEmpty) {
                            emaill = true;
                          } else if (password.text.isEmpty) {
                            passs = true;
                          } else {
                            emaill = false;
                            passs = false;
                          }
                        });

                        Map kk = {"uemail": useremail, "upass": userpass};
                        var url = Uri.parse(
                            'https://mulsha202020.000webhostapp.com/Ecommerce/login.php');
                        var response = await http.post(url, body: kk);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');

                        var daata = jsonDecode(response.body);
                        setState(() {
                          tt = Postdata.fromJson(daata);
                        });

                        if (tt!.connection == 1) {
                          if (tt!.result == 1) {
                            // logis = true;

                            homepg.prefs =
                                await SharedPreferences.getInstance();

                            homepg.prefs!
                                .setString("name", "${tt!.userdata!.nAME}");
                            homepg.prefs!
                                .setString("email", "${tt!.userdata!.eMAIL}");
                            homepg.prefs!.setString(
                                "number", "${tt!.userdata!.cONTACT}");
                            homepg.prefs!.setString(
                                "password", "${tt!.userdata!.pASSWORD}");
                            homepg.prefs!
                                .setString("date", "${tt!.userdata!.dATEE}");
                            homepg.prefs!.setString(
                                "education", "${tt!.userdata!.eDUCATION}");
                            homepg.prefs!
                                .setString("id", "${tt!.userdata!.iD}");
                            homepg.prefs!.setString(
                                "image", "${tt!.userdata!.iMAGEPATH}");

                            homepg.prefs!
                                .setBool("status", true)
                                .then((value) {
                              Future.delayed(const Duration(seconds: 2))
                                  .then((value) {
                                EasyLoading.dismiss();
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return ViewPage();
                                  },
                                ));
                              });
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text('Invalid Email And Password'),
                              action: SnackBarAction(
                                  label: 'Undo', onPressed: () {}),
                            ));
                          }
                        } else {
                          SnackBar(
                            content: const Text('Enter Email And Password'),
                            action:
                                SnackBarAction(label: 'Undo', onPressed: () {}),
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 20),
                        height: 50,
                        width: 180,
                        decoration: BoxDecoration(
                            // color: Colors.redAccent,
                            color: const Color(0XFF00b1c3),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.only(top: 13, bottom: 17),
                child: const Center(
                    child: Text(
                  "Or using social media",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0XFF346174),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.7),
                )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: AssetImage("images/facebook.png"),
                            fit: BoxFit.fill)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: const AssetImage("images/google.png"),
                            fit: BoxFit.fill)),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("images/twitter.png"),
                            fit: BoxFit.fill)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 35),
                        child: const Center(
                            child: Text(
                          "Don't have an account ?",
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        )),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return const registerpg();
                            },
                          ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: const Center(
                              child: Text(
                            "Register Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validatedemail(String value) {
    if (value.isEmpty) {
      setState(() {
        _errormsg = "Enter Email";
      });
    } else if (EmailValidator.validate(value, true)) {
      setState(() {
        _errormsg = "Invalid Email Address";
      });
    } else {
      setState(() {
        _errormsg = "";
      });
    }
  }

  Future<void> connected() async {
    var connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.mobile) {
      connection = true;
    } else if (connectivity == ConnectivityResult.wifi) {
      connection = true;
    }
    if (connection == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Check your Internet connetion'),
        duration: Duration(seconds: 3),
      ));
    }
  }
}

class Postdata {
  int? connection;
  int? result;
  Userdata? userdata;

  Postdata({this.connection, this.result, this.userdata});

  Postdata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? iD;
  String? nAME;
  String? cONTACT;
  String? dATEE;
  String? eMAIL;
  String? pASSWORD;
  String? eDUCATION;
  String? iMAGEPATH;

  Userdata(
      {this.iD,
      this.nAME,
      this.cONTACT,
      this.dATEE,
      this.eMAIL,
      this.pASSWORD,
      this.eDUCATION,
      this.iMAGEPATH});

  Userdata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    cONTACT = json['CONTACT'];
    dATEE = json['DATEE'];
    eMAIL = json['EMAIL'];
    pASSWORD = json['PASSWORD'];
    eDUCATION = json['EDUCATION'];
    iMAGEPATH = json['IMAGEPATH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NAME'] = this.nAME;
    data['CONTACT'] = this.cONTACT;
    data['DATEE'] = this.dATEE;
    data['EMAIL'] = this.eMAIL;
    data['PASSWORD'] = this.pASSWORD;
    data['EDUCATION'] = this.eDUCATION;
    data['IMAGEPATH'] = this.iMAGEPATH;
    return data;
  }
}
