import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
闹钟模块用到的数字表盘
 */
class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child,
  })
      : assert(position != null),
        super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }


  Animation<double> get position => listenable;

  final bool transformHitTests;

  final Widget child;

  //退场（出）方向
  final AxisDirection direction;

  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

class AlarmDigitalDial extends StatefulWidget {
  AlarmDigitalDial({Key key}) : super(key: key);
  @override
  _AlarmDigitalDial createState() => _AlarmDigitalDial();
}

class _AlarmDigitalDial extends State<AlarmDigitalDial> {

  static int _day=0;
  static int _hour=0;
  static int _minute =0;
  static int _second=0;
  Timer _timer ;
  TextStyle _textStyle = TextStyle(fontSize: 55, color: Colors.black );
  @override
  void deactivate() {
    super.deactivate();
    if(_timer!=null){
      _timer.cancel();
      _timer = null;
    }
  }
  @override
  void dispose() {
    super.dispose();
    if(_timer!=null){
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        if(_timer==null) {
          _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
            DateTime cur = DateTime.now();
            _day = cur.day;
            _hour = cur.hour;
            _minute =cur.minute;
            _second = cur.second;
            (context as Element).markNeedsBuild();
          });
        }
        return Row(
            children: [
              _getAnimatedSwitcher(_hour~/10),
              _getAnimatedSwitcher(_hour%10),
              Text(":",style: _textStyle),
              _getAnimatedSwitcher(_minute~/10),
              _getAnimatedSwitcher(_minute%10),
              Text(":",style: _textStyle),
              _getAnimatedSwitcher(_second~/10),
              _getAnimatedSwitcher(_second%10),
            ],
            mainAxisAlignment: MainAxisAlignment.center, //主轴显示方式
            crossAxisAlignment: CrossAxisAlignment.center
        );
      }
    );
  }

  _getAnimatedSwitcher(int value){
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        var tween=Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
        return SlideTransitionX(
          child: child,
          direction: AxisDirection.down, //上入下出
          position: animation,
        );
      },
      child: Text('$value',
        //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
        key: ValueKey<int>(value),
        style: _textStyle,
      ),
    );
  }

  stop(){
    if(_timer!=null){
      _timer.cancel();
    }
  }
}