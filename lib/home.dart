import 'dart:convert';

import 'package:clickcounter/myTabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'appcolors.dart' as Appcolors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> popularBooks = [];
  List<Map<String, dynamic>> Books = [];

  ScrollController? _scrollController;
  TabController? _tabController;

  void readData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popular.json")
        .then((s) {
      setState(() {
        popularBooks = (jsonDecode(s) as List).cast<Map<String, dynamic>>();
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((s) {
      setState(() {
        Books = (jsonDecode(s) as List).cast<Map<String, dynamic>>();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
            ),
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
            margin: EdgeInsets.only(left: 0),
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
                        itemCount: popularBooks.length,
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
          Expanded(
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Appcolors.sliverBackground,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(50.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 0.0, bottom: 20.0),
                        child: TabBar(
                            indicatorPadding: const EdgeInsets.all(0.0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: EdgeInsets.only(right: 10, left: 20),
                            isScrollable: false,
                            controller: _tabController,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 7,
                                    offset: Offset(0, 0),
                                  ),
                                ]),
                            tabs: [
                              MyTabs(color: Appcolors.menu1Color, text: "New"),
                              MyTabs(
                                  color: Appcolors.menu2Color, text: "Popular"),
                              MyTabs(
                                  color: Appcolors.menu3Color,
                                  text: "Trending"),
                            ]),
                      ),
                    ),
                  )
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                      itemCount: Books.length,
                      itemBuilder: (_, i) {
                        return Container(
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Appcolors.tabVarViewColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: Offset(0, 0),
                                    blurRadius: 2,
                                  )
                                ]),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: AssetImage(Books[i]["img"])),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 24,
                                            color: Appcolors.starColor,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            Books[i]["rating"].toString(),
                                            style: TextStyle(
                                              color: Appcolors.menu2Color,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        Books[i]["title"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Avenir"),
                                      ),
                                      Text(
                                        Books[i]["text"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Appcolors.subTitleText,
                                            fontFamily: "Avenir"),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Appcolors.loveColor,
                                        ),
                                        child: Text(
                                          "Love",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontFamily: "Avenir"),
                                        ),
                                        alignment: Alignment.center,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text("Content"),
                    ),
                  ),
                  Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text("Content"),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
