import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BottomNavigationWidget.dart';

void main() {
  runApp(ClockApp());
}

class ClockApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Clock',
        theme: ThemeData.dark(),
        home: BottomNavigationWidget()
    );
  }



}