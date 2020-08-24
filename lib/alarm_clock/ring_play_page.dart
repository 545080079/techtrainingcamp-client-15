import 'dart:async';

import 'package:techtrainingcamp_client_15/alarm_clock/alarm_data.dart';

import 'package:flutter/material.dart';
import 'alarm_digital_dial.dart';
import 'music_player.dart';
/*
闹钟播放的页面
 */
class RingPlayPage extends StatefulWidget {
  AlarmData _alarmData;
  RingPlayPage(this._alarmData,{Key key}):super(key:key);
  @override
  _RingPlayPage createState() => _RingPlayPage(_alarmData);
}

class _RingPlayPage extends State<RingPlayPage> {
  AlarmData _alarmData;
  MusicPlayer _player;
  Timer _durationTime;  //持续时间

  _RingPlayPage(this._alarmData){
    _player = MusicPlayer(_alarmData.ringUrl);

    // 到时间后关闭此界面
    _durationTime = Timer(Duration(minutes:_alarmData.ringTime ), () {
      Navigator.of(context).pop();
    });

    _player.play();
  }
  @override
  void deactivate() {
    super.deactivate();
    _player.stop();
    _durationTime.cancel();
  }
  @override
  void dispose() {
    super.dispose();
    _player.stop();
    _durationTime.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("闹钟"),
//        leading: null,
//        automaticallyImplyLeading: false,
//      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(10, 100, 10, 10), //内边距
          alignment: Alignment.center, //内容位置
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/sun.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: _getBody()
      ),
    );
  }

  _getBody(){
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10), //内边距
      alignment: Alignment.center, //内容位置
      child: ListView(
        children: [
          AlarmDigitalDial(),
          Image.asset('images/alarm_1.gif',scale: 1,),

          Align(
            alignment: Alignment.center,
            child: Text('${_alarmData.name}',style: TextStyle(fontSize: 30),),
          ),

          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: FlatButton(
              color: Color.fromRGBO(0, 87, 150, 1),
              highlightColor: Color.fromRGBO(255, 87, 124, 1),
              colorBrightness: Brightness.light,
              splashColor: Colors.grey,
              child: Text("CLOSE",style: TextStyle(fontSize: 35),),
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                _player.stop();
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }

}

