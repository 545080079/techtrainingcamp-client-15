import 'dart:async';
import 'package:flutter/material.dart';

import 'alarm_data.dart';
import 'ring_play_page.dart';

/*
 闹钟定时器管理
 */

class TimerManager{
  static Map<String,Timer> _firstTimerMap = new Map();
  static Map<String,Timer> _weekTimerMap = new Map();
  static Map<String,Timer> _repeatTimerMap = new Map();

  // 当天时间、重复播放闹钟
  static _repeatRing(context,AlarmData alarm) {
    if (!alarm.isOpen) return;
    //  播放音乐
    _playMusic(context,alarm);
    print("第1次响铃:${alarm.name},${DateTime.now().toString()}");
    // 回调多次，实现重复响铃
    int count = 1;

    var period = Duration(seconds: alarm.ringInterval * 60);
    Timer.periodic(period, (timer) {
      _repeatTimerMap[alarm.alarmID]=timer;
      if (count >= alarm.ringFrequency || !alarm.isOpen) { // 闹钟关闭时就取消回调
        //取消定时器，避免无限回调
        timer.cancel();
        timer = null;
      }
      else{
        count++;
        // 播放音乐
        _playMusic(context,alarm);
        print("第$count次响铃:${alarm.name},${DateTime.now().toString()}");
      }
    });
  }

  // 设置闹钟
  static void setAlarmTimer(context,AlarmData alarm) {
    alarm = alarm;
    if (!alarm.isOpen) return;
    DateTime curTime = DateTime.now();
    DateTime firstTime;//第一次启动时间
    if (curTime.hour < alarm.time.hour || (curTime.hour == alarm.time.hour && curTime.minute < alarm.time.minute)) {
      firstTime = DateTime(curTime.year, curTime.month, curTime.day, alarm.time.hour, alarm.time.minute, alarm.time.second);
    }
    else {
      firstTime = DateTime(curTime.year, curTime.month, curTime.day + 1, alarm.time.hour, alarm.time.minute, alarm.time.second);
    }
//    print('闹钟在：${firstTime.difference(curTime)}后响铃'); //  比较两个时间 差 小时数
    Duration durationTemp = firstTime.difference(curTime);
    print(durationTemp.toString());
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        padding:EdgeInsets.fromLTRB(120, 0, 0, 0),
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
        duration: Duration(milliseconds: 500),
        content: Text('${durationTemp.inHours}:${durationTemp.inMinutes-durationTemp.inHours*60}:${durationTemp.inSeconds-durationTemp.inMinutes*60}后响铃',style:TextStyle(fontSize: 18),),
      )
    );

    Duration cur2Target = firstTime.difference(curTime);
    Timer.periodic(cur2Target, (timer) {
      _firstTimerMap[alarm.alarmID] = timer;
      // 第一次启动
      _repeatRing(context,alarm);
      //前面通过cur2Target定时器，将时间对整，之后每天看一下是否需要启动闹钟
      var dayDuration = Duration(seconds: 24 * 60 * 60);
      Timer.periodic(dayDuration, (timer) {
        _weekTimerMap[alarm.alarmID] = timer;
        if (alarm.isOpen && alarm.repeat[AlarmData.getWeekdayStr(DateTime.now())]) { // 判断一下是否需要启动
          _repeatRing(context,alarm);
        }
      });
      if(timer.isActive) {
        timer.cancel();
        timer = null;
      }
    });
  }

  // 取消闹钟
  static void cancelAlarmTimer(context,String alarmID) {
    if(_firstTimerMap.containsKey(alarmID)){
      if(_firstTimerMap[alarmID].isActive){
        _firstTimerMap[alarmID].cancel();
        _firstTimerMap.remove(alarmID);
      }
    }
    if(_weekTimerMap.containsKey(alarmID)){
      if(_weekTimerMap[alarmID].isActive){
        _weekTimerMap[alarmID].cancel();
        _weekTimerMap.remove(alarmID);
      }
    }
    if(_repeatTimerMap.containsKey(alarmID)){
      if(_repeatTimerMap[alarmID].isActive){
        _repeatTimerMap[alarmID].cancel();
        _repeatTimerMap.remove(alarmID);
      }
    }
    print("取消闹钟：$alarmID");
  }

  static _playMusic(context,AlarmData alarm){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) {
              return RingPlayPage(alarm);
            }
        )
    );
  }
}