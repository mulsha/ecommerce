import 'package:ecommerce/bottonsheet/addproduct.dart';
import 'package:ecommerce/bottonsheet/viewproduct.dart';

import 'package:ecommerce/loginpg.dart';
import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatefulWidget {
  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  // String imagepath = "";
  // String ussid = "";
  // viewproduct? vp;
  // deleteproduct? dp;
  // bool connection = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fordata();
  }

  //
  // bool pp = false;
  //
  String name = "";
  String number = "";
  String email = "";
  String password = "";
  String date = "";
  String education = "";
  String imagepathh = "";
  String useriid = "";

  int selectindex = 0;
  List pages = [
    ViewProductPage(),
    addpropage(),
    ViewProductPage(),
    addpropage()
  ];

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
    //
    //   Map ud = {"uuserid": useriid};
    //
    //   var url = Uri.parse(
    //       'https://mulsha202020.000webhostapp.com/Ecommerce/viewproduct.php');
    //   var response = await http.post(url, body: ud);
    //   print('Response status: ${response.statusCode}');
    //   print('Response body: ${response.body}');
    //   var m = jsonDecode(response.body);
    //
    //   setState(() {
    //     vp = viewproduct.fromJson(m);
    //     pp = true;
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("View Product"),
        ),
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
                    homepg.prefs!.setBool("status", false);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return loginpg();
                      },
                    ));
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
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: selectindex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0XFF2D52EF),
            unselectedItemColor: Color(0XFFB4B4B4),
            onTap: (value) {
              setState(() {
                selectindex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline_outlined), label: 'Add'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined), label: 'Profile')
            ]),
        body: pages[selectindex]);
  }

// Future<void> connected() async {
//   var connectivity = await Connectivity().checkConnectivity();
//
//   if (connectivity == ConnectivityResult.mobile) {
//     connection = true;
//   } else if (connectivity == ConnectivityResult.wifi) {
//     connection = true;
//   }
//   if (connection == true) {
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       content: Text('Check your Internet connetion'),
//       duration: Duration(seconds: 3),
//     ));
//   }
// }
}
