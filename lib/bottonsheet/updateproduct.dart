import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ecommerce/bottonsheet/viewproduct.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class updatepropage extends StatefulWidget {
  Productdata productdata;

  updatepropage(this.productdata);

  @override
  State<updatepropage> createState() => _updatepropageState();
}

class _updatepropageState extends State<updatepropage> {
  String imgg = "";
  String proid = "";
  TextEditingController pname = TextEditingController();
  TextEditingController expectprice = TextEditingController();
  TextEditingController originalprice = TextEditingController();
  TextEditingController pdescription = TextEditingController();
  int cnt = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          "Update Product",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Product Image Add
            InkWell(
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? photo =
                    await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  imgg = photo!.path;
                  cnt = 1;
                });
                print(imgg);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: cnt == 1
                    ? Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: FileImage(File(imgg)),
                                fit: BoxFit.cover)),
                      )
                    : Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://mulsha202020.000webhostapp.com/Ecommerce/${widget.productdata.proimage}"),
                                fit: BoxFit.cover)),
                      ),
              ),
            ),
            // Product Name
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: pname,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    label: Text("Product Name",
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ))),
              ),
            ),
            //Expect Price & //Original price
            Row(
              children: [
                // Expect Price
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 10),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      controller: expectprice,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text("Expect Price",
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ))),
                    ),
                  ),
                ),
                //Original price
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 20),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      controller: originalprice,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text("Original Price",
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ))),
                    ),
                  ),
                ),
              ],
            ),
            //Product Description
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: pdescription,
                style: TextStyle(
                  color: Colors.black,
                ),
                maxLines: 3,
                decoration: InputDecoration(
                    label: Text("Product Description",
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ))),
              ),
            ),

            InkWell(
              onTap: () async {
                List<int> imagebyte = File(imgg).readAsBytesSync();
                String addimagepath = base64Encode(imagebyte);

                String proname = pname.text;
                String expprice = expectprice.text;
                String oriprice = originalprice.text;
                String description = pdescription.text;


                Map uppro = {
                  "newname": proname,
                  "newprice": expprice,
                  "newsellp": oriprice,
                  "newdescri": description,
                  "productid": widget.productdata.id,
                  "imagename": widget.productdata.proimage,
                  "updateimgdata": addimagepath,
                };
                print("##==============$uppro");
                var url = Uri.parse(
                    'https://mulsha202020.000webhostapp.com/Ecommerce/updateproduct.php');
                var response = await http.post(url, body: uppro);
                print('Response status: ${response.statusCode}');
                print('Response body update: ${response.body}');

                var pp = jsonDecode(response.body);
                UpdateProduct up = UpdateProduct.fromJson(pp);

                if (up.connection == 1) {
                  if (up.result == 1) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return ViewProductPage();
                      },
                    ));
                  }
                }
              },
              child: Container(
                height: 45,
                width: 140,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.blue, Colors.purple]),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text("Update Product",
                        style: TextStyle(fontSize: 18, color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateProduct {
  int? connection;
  int? result;

  UpdateProduct({this.connection, this.result});

  UpdateProduct.fromJson(Map<String, dynamic> json) {
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
