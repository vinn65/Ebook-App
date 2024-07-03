import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "E-Book using Flutter",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
