

import 'package:flutter/material.dart';

import 'screens/mainpage.dart';

void main() {

  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reminder',
      theme: ThemeData(
        primaryColor: Colors.teal.shade600,
        primarySwatch: Colors.pink,

      ),
      home: MainPage()
    );
  }
}
