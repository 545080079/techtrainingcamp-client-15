

import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:techtrainingcamp_client_15/ClockScreen.dart';
import 'package:techtrainingcamp_client_15/InnovationScreen.dart';
import 'package:techtrainingcamp_client_15/SecondScreen.dart';

import 'TimerScreen.dart';



class BottomNavigationWidget extends StatefulWidget {
  static int currentIndex = 0;

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _bottomNavigationColor = Colors.cyan;
  List<Widget> list = List();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('My Clock'),
      ),
      body: new Center(
        child: list[_currentIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
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
                Icons.all_inclusive,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '其它',
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
              ..add(TimerScreen())
              ..add(InnovationScreen());

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
      ..add(TimerScreen())
      ..add(InnovationScreen());
    super.initState();
  }


}

