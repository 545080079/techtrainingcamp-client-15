

import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:techtrainingcamp_client_15/alarm_clock/alarm_page.dart';
import 'package:techtrainingcamp_client_15/luoyutao/ClockScreen.dart';
import 'package:techtrainingcamp_client_15/luoyutao/InnovationScreen.dart';
import 'package:techtrainingcamp_client_15/luoyutao/SecondScreen.dart';

import 'package:techtrainingcamp_client_15/luoyutao/TimerScreen.dart';
import 'package:techtrainingcamp_client_15/weather/home_page.dart';



class BottomNavigationWidget extends StatefulWidget {
  static int currentIndex = 0;

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _bottomNavigationColor = Colors.cyan;
  List<Widget> list = List();
  int _currentIndex = 0;
  static final AlarmPage _alarmPage = AlarmPage();  // 初始化时把数据预加载一遍

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: new AppBar(
//        title: new Text('My Clock'),
//      ),
      body: new Center(
        child: list[_currentIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(34, 61, 90, 1),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.aspect_ratio,
              color: _bottomNavigationColor,
            ),
            title: Text(
                '电子钟',
              style: TextStyle(color: _bottomNavigationColor),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.av_timer,
              color: _bottomNavigationColor,
              ),
              title: Text(
                '时钟',
                style: TextStyle(color: _bottomNavigationColor),
              )
          ),BottomNavigationBarItem(
              icon: Icon(
                Icons.add_alarm,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '闹钟',
                style: TextStyle(color: _bottomNavigationColor),
              )
          ),BottomNavigationBarItem(
              icon: Icon(
                Icons.beach_access,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '天气',
                style: TextStyle(color: _bottomNavigationColor),
              )
          ),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            BottomNavigationWidget.currentIndex = index;

            list.clear();
            list..add(ClockScreen())
              ..add(SecondScreen())
              ..add(_alarmPage)
              ..add(WeatherScreen());

          });
        },
      ),
    );
  }


  @override
  void initState() {
    list..add(ClockScreen())
      //..add(ClockCustomizer((ClockModel model) => ClockScreen(model)))
      ..add(SecondScreen())
      ..add(_alarmPage)
      ..add(WeatherScreen());
    super.initState();
  }


}

