

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ecommerce/bottonsheet/viewproduct.dart';
import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addpropage extends StatefulWidget {
  const addpropage({Key? key}) : super(key: key);

  @override
  State<addpropage> createState() => _addpropageState();
}

class _addpropageState extends State<addpropage> {
  String imgg = "";
  addprodata? ap;
  bool active = true;

  TextEditingController price = TextEditingController();
  TextEditingController sellp = TextEditingController();
  TextEditingController pname = TextEditingController();
  TextEditingController descri = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Align(
                child: InkWell(
                  onTap: () {
                    final ImagePicker _picker = ImagePicker();
                    showModalBottomSheet(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        context: context,
                        builder: (context) {
                          return Column(
                            children: [
                              ElevatedButton.icon(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    final XFile? photo = await _picker.pickImage(
                                        source: ImageSource.camera);
                                    setState(() {
                                      imgg = photo!.path;
                                    });
                                  },
                                  icon: Icon(Icons.camera),
                                  label: Text("Carema")),
                              ElevatedButton.icon(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    final XFile? image = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 20);
                                    setState(() {
                                      imgg = image!.path;
                                    });
                                  },
                                  icon: Icon(Icons.photo),
                                  label: Text("Gallary"))
                            ],
                          );
                        });
                  },
                  child: imgg == ""
                      ? Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 150,
                    width: 150,
                    child: Center(
                        child: Icon(
                          Icons.add,
                          size: 40,
                        )),
                    decoration: BoxDecoration(
                      // color: Colors.orange,
                        border: Border.all(color: Colors.black45, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                  )
                      : Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      // color: Colors.orange,
                        image: DecorationImage(
                            image: FileImage(File(imgg)), fit: BoxFit.cover),
                        border: Border.all(color: Colors.black45, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 135,
                  child: TextFormField(
                    controller: price,
                    decoration: InputDecoration(
                        hintText: 'Product Price',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.red),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Container(
                  height: 50,
                  width: 135,
                  child: TextFormField(
                    controller: sellp,
                    decoration: InputDecoration(
                        hintText: 'Sell Price',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.red),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 55,
              width: 280,
              child: TextFormField(
                controller: pname,
                decoration: InputDecoration(hintText: 'Product name',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.red),
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 55,
              width: 280,
              child: TextFormField(
                controller: descri,
                decoration: InputDecoration(hintText: 'Product description',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.red),
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            InkWell(
              onTap: () async {
                List<int> imgbyte = File(imgg).readAsBytesSync();
                String addproimg = base64Encode(imgbyte);
                // print("immagew=$addproimg");

                homepg.prefs = await SharedPreferences.getInstance();
                String uid = homepg.prefs!.getString("id") ?? "";
                print("userid==$uid");

                String pprice = price.text;
                print("proihbchb==$pprice");
                String psell = sellp.text;
                String ppname = pname.text;
                String pdescri = descri.text;

                Map kk = {
                  "propris": pprice,
                  "prosell": psell,
                  "proname": ppname,
                  "prodcri": pdescri,
                  "proimage": addproimg,
                  "useridd": uid,
                };

                var url = Uri.parse(
                    'https://mulsha202020.000webhostapp.com/Ecommerce/addproduct.php');
                var response = await http.post(url, body: kk);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                var adddata = jsonDecode(response.body);
                ap = addprodata.fromJson(adddata);

                setState(() {
                  if (ap!.connection == 1) {
                    if (ap!.addproduct == 1) {
                      // ViewPage.cnt = 0;
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return ViewProductPage();
                        },
                      ));
                    }
                  }
                });
              },
              child: Container(
                height: 55,
                width: 230,
                child: Center(
                    child: Text(
                      "Add Product",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                    )),
                decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            // Container(height: 55,width: 180,child: Text("${a}"),)
          ],
        ),
      ),
    );
  }

}
class addprodata {
  int? connection;
  int? addproduct;

  addprodata({this.connection, this.addproduct});

  addprodata.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    addproduct = json['addproduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['addproduct'] = this.addproduct;
    return data;
  }
}
