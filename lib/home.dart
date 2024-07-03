import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'appcolors.dart' as Appcolors;

class MyHomePage extends StatefulWidget {
  // Expected a class member.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Expected a class member.
  List<Map<String, dynamic>> popularBooks = []; // Add null safety type

  void readData() async {
    // Change ReadData() to readData() and void return type
    await DefaultAssetBundle.of(context)
        .loadString("json/popular.json")
        .then((s) {
      setState(() {
        popularBooks = (jsonDecode(s) as List)
            .cast<Map<String, dynamic>>(); // Add type casting
      });
    });
  }

  @override
  void initState() {
    // Change Void to void

    super.initState();
    readData(); // Change ReadDate() to readData()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ImageIcon(
                  AssetImage('assets/menu.png'),
                  size: 24,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.notifications),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "Popular Books",
                  style: TextStyle(fontSize: 30),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 180,
            child: Stack(
              children: [
                Positioned(
                  left: -20,
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 180,
                    child: PageView.builder(
                        controller: PageController(viewportFraction: 0.8),
                        itemCount:
                            // ignore: unnecessary_null_comparison
                            popularBooks == null ? 0 : popularBooks.length,
                        itemBuilder: (_, i) {
                          return Container(
                            height: 180,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(popularBooks[i]["img"]),
                                  fit: BoxFit.fill,
                                )),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
