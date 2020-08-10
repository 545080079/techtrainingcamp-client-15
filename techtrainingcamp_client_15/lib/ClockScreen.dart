import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:techtrainingcamp_client_15/BottomNavigationWidget.dart';

class ClockScreen extends StatefulWidget {
  //const ClockScreen(this.model);

  //final ClockModel model;

  @override
  _ClockScreen createState() => _ClockScreen();
}

class _ClockScreen extends State<ClockScreen> {
  //final myClockBuilder = (ClockModel model) => ClockScreen(model);


  @override
  Widget build(BuildContext context) {

    //_countdown();
//    return Semantics.fromProperties(
//      properties: SemanticsProperties(
//        label: 'clock',
//      ),
      return Container(

        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          color: Colors.greenAccent.shade200,
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent.shade400, Colors.greenAccent.shade400],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),


      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Tick(),
        ),
//        child: Stack(
//          children: [
//            Positioned(
//              //left: 0,
//              //bottom: 0,
//              child: Padding(
//                padding: const EdgeInsets.all(5),
//                child: Tick(),
//              ),
//            ),
//          ],
//        ),
      ),
    );
  }

  void _countdown() {
    var seconds = 10;
    const period = const Duration(seconds: 1);
    Timer.periodic(period, (timer) {
      seconds--;
      print(seconds.toString() + '\t' + DateTime.now().toString());
      if (seconds == 0) {
        //倒计时秒数为0，取消定时器
        timer.cancel();
        timer = null;
      }
    });
  }

}



class Tick extends StatefulWidget {
  @override
  _TickState createState() => _TickState();
}

class _TickState extends State<Tick> {
  var time = DateTime.now().toString().substring(11, 19);

  static const textStyle = const TextStyle(
    fontFamily: 'Lemonada',
    fontSize: 60,
  );
  @override
  Widget build(BuildContext context) {

    Timer.periodic(Duration(seconds: 1), (timer) {
      if(BottomNavigationWidget.currentIndex != 0)
        return;

      //在切换界面再切回后，产生内存泄漏问题
      setState(() {
        time = DateTime.now().toString().substring(11, 19);
      });

    });

    print(DateTime.now().toString().substring(11, 19));
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        time,
        style: textStyle,
      ),
      );
  }


  @override
  void initState() {
    super.initState();



  }

}
