import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'alarm_detail.dart';
import 'alarm_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'timer_manager.dart';
import 'alarm_digital_dial.dart';

/*
闹钟主界面
 */
class AlarmPage extends StatefulWidget{

  AlarmPage({Key key}):super(key:key) {
    _AlarmPage().init();
  }

//  AlarmPage({Key key}):super(key:key);

  @override
  _AlarmPage createState()=>_AlarmPage();
}

class _AlarmPage extends State<AlarmPage> {
  static List<AlarmData> _alarmDataList = []; //闹钟列表
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static List<String> _alarmIDList = [];   // 闹钟ID存一下
  static bool _isInit = false;
  TextStyle _textStyleLarge = TextStyle(fontSize: 24,color: Colors.black);
  TextStyle _textStyleSmall = TextStyle(fontSize: 18,color: Colors.black);
  init(){
    if (_isInit) return;

    _prefs.then((SharedPreferences prefs) {
      var temp = prefs.getStringList("AlarmIDList");
      return temp ;
    }).then((value){
      if(value!=null){
        _alarmIDList = value;
      }
    });

    _prefs.then((SharedPreferences prefs) {
      List<AlarmData> temp = [];
      for (int i = 0; i < _alarmIDList.length; i++) {
        temp.add(
            AlarmData.fromStringList(prefs.getStringList(_alarmIDList[i])));
      }
      return temp;
    }).then((value) {
      _alarmDataList = value;
      _isInit = true;
      for(int i=0;i<_alarmDataList.length;i++){
          TimerManager.setAlarmTimer(context, _alarmDataList[i]);// 把之前的闹钟设置一下
      }
    });

  }
  _AlarmPage() {
    // 初始化时延时加载闹钟，不然可能加载不上
//    const timeout = const Duration(milliseconds: 10);
//    Timer(timeout, () {
//      _init();
//    });
  }



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text("闹钟"),),
      body: Container(
          padding: EdgeInsets.fromLTRB(10, 50, 10, 10), //内边距
          alignment: Alignment.center, //内容位置
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/sun.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 100,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                alignment: Alignment.center,
                child:AlarmDigitalDial() ,
              ),
              Expanded(child: _alarmTimeBarList()),
            ],
            mainAxisAlignment: MainAxisAlignment.start, //主轴显示方式
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
      ),

      floatingActionButton: FloatingActionButton(
          tooltip: "添加闹钟",
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push( // 跳转页面
                MaterialPageRoute(
                    builder: (context) {
                      return AlarmDetailPage(AlarmData());
                    }
                )
            ).then((value) {
              if (value == null) return;
              setState(() {
                _addAlarm(value);
              });
            }
            );
          },
        foregroundColor: Colors.white70,
        backgroundColor: Color.fromRGBO(0, 194 , 219, 0.5),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // 加载闹钟条，可能没有闹钟，需要判断一下
  _alarmTimeBarList() {
    if (_alarmDataList.length == 0) {
      return Center(
          child: Column(
            children: [
              Icon(Icons.alarm_off, size: 100,color: Colors.black54,),
              Text("没有闹钟",style: TextStyle(fontSize: 24,color: Colors.black54),)
            ],
          )
      );
    }
    else {
      return Container(
        child: ListView.builder(
          itemCount: _alarmDataList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              // Key
              key: Key('key${_alarmDataList[index].alarmID}'),
              // Child
              child: _getTimeBar(index),
              onDismissed: (direction){
                // 删除后刷新列表，以达到真正的删除
                setState(() {
                  _delAlarm(index);
                });
              },
              background: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                alignment: Alignment.centerLeft,
                color: Color.fromRGBO(240, 190, 190, 0.2),
                child: Icon(Icons.delete, color: Colors.deepOrangeAccent,),
              ),
              secondaryBackground: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                alignment: Alignment.centerRight,
                color: Color.fromRGBO(240, 190, 190, 0.2),
                child: Icon(Icons.delete, color: Colors.deepOrangeAccent,),
              ),
            );
//              _getTimeBar(index);
          },
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
        ),
      );
    }
  }

  // 一个时间条，根据_alarmDataList中的内容，创建一个闹钟条
  _getTimeBar(int index) {
    return Container(
      height: 90.0,
      child: Stack(
        alignment: Alignment.center, // 堆叠位置方式
        children: <Widget>[
          Align( // 调整方位
              alignment: Alignment.centerLeft,
              child: Builder(
                  builder: (BuildContext context) {
                    return ListTile(
//                      hoverColor: Colors.red,
//                      focusColor: Colors.amberAccent,
//                      selectedTileColor: Colors.blue,
//                      tileColor: Color.fromRGBO(255, 255, 255, 0.01),
                      leading: Icon(Icons.alarm_add, color: Colors.cyan,),
                      title: Text("${_alarmDataList[index].time
                          .hour}:${_alarmDataList[index].time.minute}",
                        style: _textStyleLarge,),
                      subtitle: Text(
                        "${_alarmDataList[index].name}；${_alarmDataList[index]
                            .transRepeat2Str()}",
                        style: _textStyleSmall,
                      ),
                      onTap: () {
                        Navigator.of(context).push( // 跳转页面
                            MaterialPageRoute(
                                builder: (context) {
                                  return AlarmDetailPage(_alarmDataList[index]);
                                }
                            )
                        ).then((value) {
                          (context as Element).markNeedsBuild();
                          if (value == null) return;
                          _alarmDataList[index] = value;
                          TimerManager.setAlarmTimer(context, _alarmDataList[index]);
                          setState(() {
                            _alarmDataList[index].isOpen = true;
                          });
                        }
                        );
                      },
                      onLongPress: () {
                        //长按删除
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Color.fromRGBO(255, 255, 255, 0.85),
                                  title: Text(
                                      '删除${_alarmDataList[index].name}?'),
                                  actions: <Widget>[
                                    FlatButton(
                                        child: Text('Cancel'),
                                        onPressed: () =>
                                            Navigator.of(context).pop()),
                                    FlatButton(
                                        child: Text('Yes'),
                                        onPressed: () {
                                          setState(() {
                                            _delAlarm(index);
                                          });
                                          Navigator.of(context).pop();
                                        })
                                  ]);
                            });
                      },
                    );
                  }
              )

          ),
          Align(
            alignment: Alignment.centerRight,
            child: Switch(
              value: _alarmDataList[index].isOpen, //当前状态
              onChanged: (value) { //重新构建页面
                setState(() {
                  _alarmDataList[index].isOpen = value;
                  if(value){
                    TimerManager.setAlarmTimer(context,_alarmDataList[index]);
                  }
                  else{
                    TimerManager.cancelAlarmTimer(context,_alarmDataList[index].alarmID);
                  }
                });
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Divider(),
          )

        ],

      ),
    );
  }

  // 添加闹钟
  _addAlarm(AlarmData alarm) async {
    _alarmDataList.add(alarm);
    _alarmIDList.add(alarm.alarmID);
    // 保存到本地
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("AlarmIDList", _alarmIDList);
    prefs.setStringList(alarm.alarmID, alarm.transAll2Str());
    // 设置定时器
    TimerManager.setAlarmTimer(context,_alarmDataList[_alarmDataList.length-1]);
  }

  // 删除闹钟
  _delAlarm(int index) async {
    _alarmIDList.remove(_alarmDataList[index].alarmID);
    // 取消闹钟
    TimerManager.cancelAlarmTimer(context,_alarmDataList[index].alarmID);
    // 从本地删除
    final SharedPreferences prefs = await _prefs;
    prefs.remove(_alarmDataList[index].alarmID);
    prefs.setStringList("AlarmIDList", _alarmIDList);

    _alarmDataList.removeAt(index);
  }
}

