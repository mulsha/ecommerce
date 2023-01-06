import 'dart:convert';
import 'package:ecommerce/bottonsheet/addproduct.dart';
import 'package:ecommerce/bottonsheet/updateproduct.dart';
import 'package:ecommerce/fullviewpage.dart';
import 'package:ecommerce/loginpg.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';

class ViewProductPage extends StatefulWidget {
  const ViewProductPage({Key? key}) : super(key: key);

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  bool pp = false;
  String name = "";
  String number = "";
  String email = "";
  String password = "";
  String date = "";
  String education = "";
  String imagepathh = "";
  String useriid = "";

  String imagepath = "";
  String ussid = "";
  viewproduct? vp;
  deleteproduct? dp;
  bool connection = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fordata();
  }

  Future<void> fordata() async {
    name = homepg.prefs!.getString("name") ?? "";
    print("namee==$name");
    number = homepg.prefs!.getString("number") ?? "";
    email = homepg.prefs!.getString("email") ?? "";
    print("emaill==$email");
    password = homepg.prefs!.getString("password") ?? "";
    date = homepg.prefs!.getString("date") ?? "";
    education = homepg.prefs!.getString("education") ?? "";
    useriid = homepg.prefs!.getString("id") ?? "";

    Map ud = {"uuserid": useriid};

    var url = Uri.parse(
        'https://mulsha202020.000webhostapp.com/Ecommerce/viewproduct.php');
    var response = await http.post(url, body: ud);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var m = jsonDecode(response.body);

    setState(() {
      vp = viewproduct.fromJson(m);
      pp = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white54,
        elevation: 15,
        child: Container(
          width: 50,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://mulsha202020.000webhostapp.com/Ecommerce/${homepg.prefs!.getString("image") ?? ""}"),
                  ),
                  accountName: Text("$name"),
                  accountEmail: Text("$email")),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    // ViewPage.cnt = 0;
                  });
                },
                leading: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "View Product",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return addpropage();
                    },
                  ));
                },
                leading: Icon(
                  Icons.add_box_outlined,
                  color: Colors.black,
                ),
                title: Text(
                  "Add Product",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Spacer(),
              ListTile(
                onTap: () {
                  homepg.prefs!.setBool("status", false).then((value) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return loginpg();
                      },
                    ));
                  });
                },
                title: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: pp
          ? vp!.productdata == null
              ? Center(
                  child: Text("Add Product"),
                )
              : ListView.builder(
                  itemCount: vp!.productdata!.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: ValueKey(0),
                      endActionPane: ActionPane(motion: ScrollMotion(),
                          // dismissible: DismissiblePane(
                          //   onDismissed: () {},
                          // ),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                homepg.prefs!.setString(
                                    "pid", "${vp?.productdata![index].id}");

                                String proid =
                                    homepg.prefs!.getString("pid") ?? "";
                                print("product id==$proid");

                                Map pm = {
                                  "productid": proid,
                                };

                                var url = Uri.parse(
                                    'https://mulsha202020.000webhostapp.com/Ecommerce/deleteproduct.php');
                                var response = await http.post(url, body: pm);
                                print(
                                    'Response status: ${response.statusCode}');
                                print('Response body: ${response.body}');

                                var deletedata = jsonDecode(response.body);
                                dp = deleteproduct.fromJson(deletedata);

                                if (dp!.connection == 1 && dp!.result == 1) {
                                  fordata();
                                }
                              },
                              icon: Icons.delete_outlined,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return updatepropage(
                                        vp!.productdata![index]);
                                  },
                                ));
                              },
                              icon: Icons.edit,
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            )
                          ]),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            String? p1 = vp!.productdata![index].proimage;
                            String? p2 = vp!.productdata![index].productname;
                            print("nhjbv=======$p2");
                            String? p3 = vp!.productdata![index].desctription;
                            String? p4 = vp!.productdata![index].productprice;

                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return fullview(p1!, p2!, p3!, p4!);
                              },
                            ));
                          },
                          title: Text("${vp!.productdata![index].productname}"),
                          leading: Image.network(
                              "https://mulsha202020.000webhostapp.com/Ecommerce/${vp!.productdata![index].proimage}"),
                          subtitle:
                              Text("${vp!.productdata![index].desctription}"),
                        ),
                      ),
                    );
                  },
                )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class viewproduct {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  viewproduct({this.connection, this.result, this.productdata});

  viewproduct.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? id;
  String? productname;
  String? productprice;
  String? prosellprice;
  String? desctription;
  String? proimage;
  String? userid;

  Productdata(
      {this.id,
      this.productname,
      this.productprice,
      this.prosellprice,
      this.desctription,
      this.proimage,
      this.userid});

  Productdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productname = json['Productname'];
    productprice = json['Productprice'];
    prosellprice = json['prosellprice'];
    desctription = json['desctription'];
    proimage = json['proimage'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Productname'] = this.productname;
    data['Productprice'] = this.productprice;
    data['prosellprice'] = this.prosellprice;
    data['desctription'] = this.desctription;
    data['proimage'] = this.proimage;
    data['userid'] = this.userid;
    return data;
  }
}

class deleteproduct {
  int? connection;
  int? result;

  deleteproduct({this.connection, this.result});

  deleteproduct.fromJson(Map<String, dynamic> json) {
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
