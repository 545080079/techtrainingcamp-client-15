import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techtrainingcamp_client_15/DrawnHand.dart';
import 'package:techtrainingcamp_client_15/backgroundView.dart';
import 'package:vector_math/vector_math_64.dart' show radians;


/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);


class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "drawn clock",
      home: DrawnClock(),
    );
  }
}


class DrawnClock extends StatefulWidget {
  @override
  _DrawnClockState createState() => _DrawnClockState();
}

class _DrawnClockState extends State<DrawnClock> {
  var _now = DateTime.now();
  Timer _timer;

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          BackgroundView(

          ),
          DrawnHand(
            color: Colors.cyanAccent,
            thickness: 5,
            size: 0.75,
            angleRadians: _now.second * radiansPerTick,
          ),
          DrawnHand(
            color: Colors.teal,
            thickness: 5,
            size: 0.5,
            angleRadians: _now.minute * radiansPerTick,
          ),
          DrawnHand(
            color: Colors.lightBlueAccent,
            thickness: 5,
            size: 0.35,
            angleRadians: _now.hour * radiansPerTick,
          ),
        ],
      )

      );
  }
}
