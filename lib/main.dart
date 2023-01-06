import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:ecommerce/loginpg.dart';
import 'package:ecommerce/registerpg.dart';
import 'package:ecommerce/viewpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: homepg(),debugShowCheckedModeBanner: false,
  ));
}

class homepg extends StatefulWidget {
  static SharedPreferences? prefs;
  static int? p;

  @override
  State<homepg> createState() => _homepgState();
}

class _homepgState extends State<homepg> {
  int pageindex = 0;

  bool store = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharefor();
  }

  Future<void> sharefor() async {
    homepg.prefs = await SharedPreferences.getInstance();

    setState(() {
      store = homepg.prefs!.getBool("status") ?? false;
    });

    Future.delayed(Duration(seconds: 3)).then((value) {
      if (store) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return ViewPage();
          },
        ));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return loginpg();
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double tht = MediaQuery.of(context).size.height;
    double tw = MediaQuery.of(context).size.width;
    double bottom = MediaQuery.of(context).padding.bottom;
    double top = MediaQuery.of(context).padding.top;
    double th = tht - bottom - top;

    List<Widget> pages = [
      Column(
        children: [
          Container(
            height: th * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
                // color: Colors.cyanAccent,
                image: DecorationImage(
                    image: AssetImage("images/home.jpg"), fit: BoxFit.fill)),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: th * 0.12,
            width: tw * 0.73,
            margin: EdgeInsets.fromLTRB(70, 0, 0, 0),
            child: Text(
              "Don't cry because it's over, smile because it happened.",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0XFF02465b),
                  fontWeight: FontWeight.w600),
            ),
            // decoration: BoxDecoration(color: Colors.red),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            height: th * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
                // color: Colors.cyanAccent,
                image: DecorationImage(
                    image: AssetImage("images/2.png"), fit: BoxFit.fill)),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: th * 0.12,
            width: tw * 0.75,
            margin: EdgeInsets.fromLTRB(70, 0, 0, 0),
            child: Text(
              "Be yourself,everyone else is already taken.",
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0XFF02465b),
                  fontWeight: FontWeight.w600),
            ),
            // decoration: BoxDecoration(color: Colors.red),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            height: th * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
                // color: Colors.cyanAccent,
                image: DecorationImage(
                    image: AssetImage("images/3.jpg"), fit: BoxFit.fill)),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: th * 0.12,
            width: tw * 0.75,
            margin: EdgeInsets.fromLTRB(70, 0, 0, 0),
            child: Text(
              "So many books, so little time.",
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0XFF02465b),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            height: th * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/4.jpg"), fit: BoxFit.fill)),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: th * 0.12,
            width: tw * 0.74,
            margin: EdgeInsets.fromLTRB(70, 0, 0, 0),
            child: Text(
              "A room without books is like a body without a soul.",
              maxLines: 3,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0XFF02465b),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    ];
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: th * 0.06,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return loginpg();
                },
              ));
            },
            child: Container(
              margin: EdgeInsets.only(left: 230),
              height: th * 0.04,
              width: tw * 0.2,
              child: Center(
                  child: Text(
                "Skip",
                style: TextStyle(
                    fontSize: 17,
                    color: Color(0XFFf1f1f1),
                    fontWeight: FontWeight.w500),
              )),
              decoration: BoxDecoration(
                  color: Color(0XFF00b1c3),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ),
          ),
          SizedBox(
            height: th * 0.01,
          ),
          Container(
            height: th * 0.63,
            width: double.infinity,
            child: PageView(
              children: pages,
              onPageChanged: (index) {
                setState(() {
                  pageindex = index;
                });
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          CarouselIndicator(
            count: pages.length,
            index: pageindex,
            color: Color(0XFF00b1c3),
            activeColor: Colors.grey,
            height: 3,
            width: 20,
            space: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return registerpg();
                },
              ));
            },
            child: Container(
              margin: EdgeInsets.only(left: 85, top: 40),
              height: th * 0.07,
              width: tw * 0.7,
              child: Center(
                  child: Text(
                "Sign Up ...    ",
                style: TextStyle(
                    fontSize: 25,
                    color: Color(0XFFf1f1f1),
                    fontWeight: FontWeight.w500),
              )),
              decoration: BoxDecoration(
                  color: Color(0XFF00b1c3),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      topLeft: Radius.circular(30))),
            ),
          ),
          SizedBox(
            height: th * 0.08,
          )
        ],
      ),
    );
  }
}
