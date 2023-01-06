import 'dart:convert';
import 'dart:io';
import 'package:ecommerce/loginpg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class registerpg extends StatefulWidget {
  const registerpg({Key? key}) : super(key: key);

  @override
  State<registerpg> createState() => _registerpgState();
}

class _registerpgState extends State<registerpg> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController edu = TextEditingController();
  bool namep = false;
  bool emailp = false;
  bool passp = false;
  bool numberp = false;
  DateTime selecttime = DateTime.now();
  bool edup = false;
  bool datep = false;
  String immg = "";
  Postdata? mm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFF00adbe),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    final ImagePicker _picker = ImagePicker();
                    showModalBottomSheet(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        context: context,
                        builder: (context) {
                          return Column(
                            children: [
                              ElevatedButton.icon(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    final XFile? photo = await _picker
                                        .pickImage(source: ImageSource.camera);
                                    setState(() {
                                      immg = photo!.path;
                                    });
                                  },
                                  icon: Icon(Icons.camera),
                                  label: Text("Carema")),
                              ElevatedButton.icon(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    final XFile? image =
                                        await _picker.pickImage(
                                            source: ImageSource.gallery,
                                            imageQuality: 20);
                                    setState(() {
                                      immg = image!.path;
                                    });
                                  },
                                  icon: Icon(Icons.photo),
                                  label: Text("Gallary"))
                            ],
                          );
                        });
                  },
                  child: immg == ""
                      ? CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage("images/resiterprofile.png"),
                        )
                      : CircleAvatar(
                          radius: 35,
                          foregroundImage: FileImage(File(immg)),
                        ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      color: Color(0XFFededed),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Center(
                            child: Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              color: Color(0XFF07a2b4)),
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(13, 5, 13, 5),
                        child: TextFormField(
                          controller: name,
                          decoration: InputDecoration(
                              errorText: namep ? "Please Enter Name" : null,
                              hintText: 'Name',
                              prefixIcon: Icon(
                                  Icons.drive_file_rename_outline_outlined,
                                  color: Color(0XFF009bb9)),
                              hintStyle: TextStyle(
                                  color: Color(0XFF009bb9),
                                  fontSize: 16,
                                  letterSpacing: 0.8)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                        child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                              errorText: emailp ? "Please Enter Email" : null,
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined,
                                  color: Color(0XFF009bb9)),
                              hintStyle: TextStyle(
                                  color: Color(0XFF009bb9),
                                  fontSize: 16,
                                  letterSpacing: 0.8)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                        child: TextFormField(
                          controller: number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              errorText: numberp
                                  ? "Please Enter Contact Number"
                                  : null,
                              hintText: 'Contact Number',
                              prefixIcon:
                                  Icon(Icons.call, color: Color(0XFF009bb9)),
                              hintStyle: TextStyle(
                                  color: Color(0XFF009bb9),
                                  fontSize: 16,
                                  letterSpacing: 0.8)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                        child: Center(
                            child: TextField(
                          controller: date,
                          decoration: InputDecoration(
                              errorText: datep ? "Please select Date" : null,
                              prefixIcon: Icon(Icons.calendar_month_outlined,
                                  color: Color(0XFF009bb9)),
                              hintText: 'Select Date',
                              hintStyle: TextStyle(
                                  color: Color(0XFF009bb9),
                                  fontSize: 16,
                                  letterSpacing: 0.8)
                              // errorText: thirdv ? "Please Select Date" : null,
                              ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2019, 3),
                                lastDate: DateTime(2023));
                            if (picked != null) {
                              print("picked===$picked");
                              String formatedate =
                                  DateFormat('dd-MM-yyyy').format(picked);
                              print("formatedate===$formatedate");
                              setState(() {
                                date.text = formatedate;
                              });
                            }
                          },
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                        child: DropDownTextField(
                          dropDownList: [
                            DropDownValueModel(
                                name: '10th pass', value: "value1"),
                            DropDownValueModel(
                                name: '12th pass', value: "value1"),
                            DropDownValueModel(name: 'B.COM', value: "value1"),
                            DropDownValueModel(name: 'M.COM', value: "value1"),
                            DropDownValueModel(name: 'BCA', value: "value1"),
                            DropDownValueModel(name: 'MCA', value: "value1"),
                            DropDownValueModel(name: 'MBBS', value: "value1"),
                            DropDownValueModel(name: 'Others', value: "value1")
                          ],
                          dropDownItemCount: 8,
                          textFieldDecoration: InputDecoration(
                              prefixIcon: Icon(Icons.school_outlined,
                                  color: Color(0XFF009bb9)),
                              // errorText:
                              //     edup ? "Please Select Education" : null,
                              hintText: 'Select Education',
                              hintStyle: TextStyle(
                                  color: Color(0XFF009bb9),
                                  fontSize: 16,
                                  letterSpacing: 0.8)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 5, 12, 5),
                        child: TextFormField(
                          controller: password,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(8),
                          ],
                          decoration: InputDecoration(
                              errorText: passp ? "Please Enter Password" : null,
                              suffixIcon: Icon(Icons.remove_red_eye_outlined),
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline_rounded,
                                  color: Color(0XFF009bb9)),
                              hintStyle: TextStyle(
                                  color: Color(0XFF009bb9),
                                  fontSize: 16,
                                  letterSpacing: 0.8)),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          List<int> imgbyte = File(immg).readAsBytesSync();
                          String profileimg = base64Encode(imgbyte);

                          String username = name.text;
                          String usernumber = number.text;
                          String useremail = email.text;
                          String userpass = password.text;
                          String userdate = date.text;

                          setState(() {
                            if (name.text.isEmpty) {
                              namep = true;
                            } else if (email.text.isEmpty) {
                              emailp = true;
                            } else if (number.text.isEmpty) {
                              numberp = true;
                            } else if (password.text.isEmpty) {
                              passp = true;
                            } else if (edu.text.isEmpty) {
                              edup = true;
                            } else if (date.text.isEmpty) {
                              datep = true;
                            } else {
                              namep = false;
                              emailp = false;
                              passp = false;
                              edup = false;
                              numberp = false;
                              datep = false;
                            }
                          });

                          Map pp = {
                            "name": username,
                            "number": usernumber,
                            "email": useremail,
                            "password": userpass,
                            "date": userdate,
                            "education": "usereducation",
                            "imagepath": profileimg,
                          };

                          var url = Uri.parse(
                              'https://mulsha202020.000webhostapp.com/Ecommerce/register.php');
                          var response = await http.post(url, body: pp);
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');

                          var dttta = jsonDecode(response.body);
                          setState(() {
                            mm = Postdata.fromJson(dttta);
                          });

                          if (mm!.connection == 1) {
                            if (mm!.result == 1) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return loginpg();
                                },
                              ));
                            }
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15, bottom: 10),
                          height: 50,
                          width: 170,
                          decoration: BoxDecoration(
                              // color: Colors.redAccent,
                              color: Color(0XFF00b1c3),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Text(
                            "Register",
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
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(top: 8, bottom: 12),
                  child: Center(
                      child: Text(
                    "Or using social media",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.7),
                  )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("images/facebook.png"),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("images/google.png"),
                              fit: BoxFit.fill)),
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("images/twitter.png"),
                              fit: BoxFit.fill)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}

class Postdata {
  int? connection;
  int? result;

  Postdata({this.connection, this.result});

  Postdata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
