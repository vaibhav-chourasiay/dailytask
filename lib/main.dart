import 'package:daily_task/utilties/mytheme.dart';
import 'package:flutter/material.dart';

import 'screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: "Daily Task",
      theme: Mytheme.light,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
