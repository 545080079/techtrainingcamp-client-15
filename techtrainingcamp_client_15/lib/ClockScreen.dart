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

//        decoration: BoxDecoration(
//          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
//          color: Colors.greenAccent.shade200,
//          gradient: LinearGradient(
//            colors: [Colors.lightBlueAccent.shade400, Colors.greenAccent.shade400],
//            begin: Alignment.centerRight,
//            end: Alignment.centerLeft,
//          ),
//        ),

        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/b1_rainy.gif'),
                fit: BoxFit.cover
            )
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
  Timer timer;
  var time, hours, minutes, seconds;
  var flash = " : ";
  static const mathStyle = const TextStyle(
    fontFamily: 'Math',
    fontSize: 60,
  );
  static const defultStyle = const TextStyle(
    fontFamily: 'Lemonada',
    fontSize: 60,
  );
  @override
  Widget build(BuildContext context) {


    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text.rich(TextSpan(
        children: [
          TextSpan(
            text: hours,
            style: mathStyle,
          ),
            TextSpan(
              text: flash,
              style: defultStyle,
            ),
          TextSpan(
            text: minutes,
            style: mathStyle,
          ),
          TextSpan(
            text: flash,
            style: defultStyle,
          ),
          TextSpan(
            text: seconds,
            style: mathStyle,
          ),
        ]
      )
      ),
      );
  }


  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer _timer) {
      //在切换界面再切回后，产生内存泄漏问题
      //通过BottomNavigationWidget.dart重新添加4个页面入List解决频繁内存泄漏，但还是有一次调用setState()是在dispose()之后
      if(BottomNavigationWidget.currentIndex != 0) {
        timer.cancel();
      }

      setState(() {
        time = DateTime.now().toString().substring(11, 19);
        hours = time.toString().substring(0,2);
        minutes = time.toString().substring(3,5);
        seconds = time.toString().substring(6, time.toString().length);
        flash = flash[1] == ':' ? "   " : " : ";
        debugPrint(hours + "\t:" + minutes + "\t:" + seconds);
      });

    });
  }

}
