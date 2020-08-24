import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'alarm_data.dart';
import 'ring_select_page.dart';

/*
闹钟编辑页内容
 */
class AlarmDetailPage extends StatefulWidget{
  AlarmData _alarmData;
  AlarmDetailPage(this._alarmData,{Key key}):super(key:key);
  @override
  _AlarmDetailPage createState()=>_AlarmDetailPage(_alarmData);
}

class _AlarmDetailPage extends State<AlarmDetailPage> {
  AlarmData _alarmData;
  _AlarmDetailPage(this._alarmData);
  TextStyle _textStyleLarge = TextStyle(fontSize: 22,color: Colors.black,);
  TextStyle _textStyleSmall = TextStyle(fontSize: 18,color: Colors.black,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("编辑闹钟",style: _textStyleLarge,),
          leading: IconButton(
            icon:Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop(null);
            }
          ),
          backgroundColor: Color.fromRGBO(241 , 180, 180, 0.8),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.check),
                onPressed: (){
                  Navigator.of(context).pop(_alarmData);
                })
          ],
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 50, 10, 10), //内边距
          alignment: Alignment.center, //内容位置
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/sun.jpg"),
              fit: BoxFit.cover,),
          ),
          child:
              ListView(
              children: [
                _time(),
                Divider(),
                _repetition(),
                Divider(),
                _ring(),
                Divider(),
  //              _vibration(),
  //              Divider(),
                _alarmName(),
                Divider(),
                _ringTime(),
                Divider(),
                _ringInterval(),
                Divider(),
              ]
          )
        )
    );
  }

//  _textHour(){
//    List<Widget> temp = List<Widget>();
//    for(int i=0;i<24;i++){
//      temp.add(Text('$i',style: _textStyleLarge,));
//    }
//    return temp;
//  }
//  _textMinute(){
//    List<Widget> temp = List<Widget>();
//    for(int i=0;i<60;i++){
//      temp.add(Text('$i',style: _textStyleLarge,));
//    }
//    return temp;
//  }
  // 编辑时间
  _time(){
    return Container(
        height: 200,
        padding: EdgeInsets.fromLTRB(60, 10, 60, 10), //内边距
        alignment: Alignment.bottomCenter, //内容位置

//        child:Row(
//          children: [
//            Expanded(
//              child: CupertinoPicker(
//  //        backgroundColor: Colors.white, //选择器背景色
//                itemExtent: 45, //item的高度
//
//                onSelectedItemChanged: (index) { //选中item的位置索引
//                  print("index = $index}");
//                  _alarmData.time = DateTime(2020,1,1,index,_alarmData.time.minute,0);
//                },
//                children: _textHour(),
//              ),
//            ),
//            Text("hour",style: _textStyleSmall,),
//            Expanded(
//              child: CupertinoPicker(
//  //        backgroundColor: Colors.white, //选择器背景色
//                itemExtent: 45, //item的高度
//                onSelectedItemChanged: (index) { //选中item的位置索引
//                  print("index = $index}");
//                  _alarmData.time = DateTime(2020,1,1,_alarmData.time.hour,index,0);
//                },
//                children: _textMinute(),
//              ),
//            ),
//            Text("minute",style: _textStyleSmall,),
//
//          ],
//        )
      child:CupertinoTimerPicker(
        mode: CupertinoTimerPickerMode.hm, //可以设置时分、时分秒和分秒三种模式
        initialTimerDuration: Duration(hours: _alarmData.time.hour, minutes: _alarmData.time.minute, seconds: 0), // 默认显示的时间值
        onTimerDurationChanged: (duration) {
          //print('当前选择了：${duration.inHours}时${duration.inMinutes-duration.inHours*60}分${duration.inSeconds-duration.inMinutes*60}秒');
//          var temp=TimeOfDay(hour:duration.inHours,minute:duration.inMinutes-duration.inHours*60);
          _alarmData.time = DateTime.fromMicrosecondsSinceEpoch(duration.inMicroseconds);
          _alarmData.time = DateTime(2020,1,1,duration.inHours,duration.inMinutes-duration.inHours*60,0);

        },
        alignment: Alignment.center, //内容位置
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
      )
//      child: CupertinoDatePicker(
//        mode: CupertinoDatePickerMode.time, //日期时间模式，此处为时间模式
//        onDateTimeChanged: (dateTime) {
//          if (dateTime == null) {
//            return;
//          }
//          print('当前选择了：${dateTime.hour}时${dateTime.minute}分${dateTime.second}秒');
//        },
//        initialDateTime: DateTime.now(),
//        use24hFormat: true, // 是否使用24小时格式，此处使用
//      ),

    );

  }

  // 重复方式
  _repetition() {
    _getTimeContainer(String weekDay) {
      return Container(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 0), //内边距
//          decoration: BoxDecoration(  // 边框
//              color: Colors.lightBlueAccent,  //背景颜色
//              border: Border.all(
//                  color: Colors.blue, //边框颜色
//                  width: 2.0
//              ),
//              borderRadius: BorderRadius.all( //边框圆角
//                Radius.circular(10),
//              )
//          ),
          child: Builder(builder:(BuildContext context) {
              return InkWell(
                onTap:  () {
                  (context as Element).markNeedsBuild();
                  _alarmData.repeat[weekDay] = !_alarmData.repeat[weekDay];
                },
                child: Stack(
                  alignment: Alignment.center, // 堆叠位置方式
                  children: <Widget>[
                    Align( // 调整方位
                      alignment: Alignment.centerLeft,
                      child: Text(weekDay,style: _textStyleLarge,),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Checkbox(
                        activeColor: Colors.cyan,
                        checkColor: Colors.black54,
                        value: _alarmData.repeat[weekDay],
                        onChanged: (bool value) {
                          (context as Element).markNeedsBuild();
                          _alarmData.repeat[weekDay] = !_alarmData.repeat[weekDay];
                        },
                      )
                    ),
                  ],
                ),
              );
            }
          )
      );
    }

    _getRepetitionDialog(){
      return showModalBottomSheet<int>(
          context: context,
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          backgroundColor:Color.fromRGBO(120, 160, 190, 1),
          barrierColor:Color.fromRGBO(0, 0, 0, 0.5),
          builder: (context){
            return Container(
              height: 400,
//              decoration: BoxDecoration(  // 边框
//                  color: Color.fromRGBO(77, 120, 150, 0.5),  //背景颜色
//                  border: Border.all(
//                      color: Colors.white60, //边框颜色
//                      width: 1.0
//                  ),
//                  borderRadius: BorderRadius.all( //边框圆角
//                    Radius.circular(15),
//                  )
//              ),
              child: ListView(
                shrinkWrap:true,
                children: <Widget>[
                  _getTimeContainer("周一"),
                  Divider(),
                  _getTimeContainer("周二"),
                  Divider(),
                  _getTimeContainer("周三"),
                  Divider(),
                  _getTimeContainer("周四"),
                  Divider(),
                  _getTimeContainer("周五"),
                  Divider(),
                  _getTimeContainer("周六"),
                  Divider(),
                  _getTimeContainer("周日"),
               ],

              ),

            );
          }
      );

//      bool _withTree = false; //记录复选框是否选中
//      return showDialog<bool>(
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            title: Text("重复"),
//            content: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                    _getTimeContainer("周一"),
//                  ],
//            ),
//            actions: <Widget>[
//              FlatButton(
//                child: Text("取消"),
//                onPressed: () => Navigator.of(context).pop(),
//              ),
//              FlatButton(
//                child: Text("删除"),
//                onPressed: () {
//                  // 将选中状态返回
//                  Navigator.of(context).pop(_withTree);
//                },
//              ),
//            ],
//          );
//        },
//      );
    }


    return Container(
      height: 50.0,
      child: Builder(
          builder:(BuildContext context){
            return InkWell(
              onTap: ()async{
//                (context as Element).markNeedsBuild();
                await _getRepetitionDialog().then((index){
                     (context as Element).markNeedsBuild();
                });
                },
              child: Stack(
                  alignment: Alignment.center, // 堆叠位置方式
                  children: <Widget>[
                    Align( // 调整方位
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            "重复", style: _textStyleLarge,),
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                        )
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: Text(_alarmData.transRepeat2Str(),
                            style: _textStyleLarge,
                            overflow: TextOverflow.ellipsis, //文本过长时的显示方式
                            maxLines: 1,),
                          padding: EdgeInsets.fromLTRB(120, 0, 25, 0),
                        )
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: Icon(Icons.arrow_forward_ios,size: 16,color: Colors.black,),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        )
                    ),
                  ]
                )
            );
          }
        )
      );
  }

  // 铃声
  _ring(){
    return Container(
        height: 50.0,
        child: Builder(
            builder:(BuildContext context){
              return InkWell(
                  onTap: (){
                    Navigator.of(context).push( // 跳转页面
                        MaterialPageRoute (
                            builder: (context) {return  RingManagerPage(_alarmData);}
                        )
                    ).then((value){
                      if(value==null)return;
                      (context as Element).markNeedsBuild();
                      _alarmData=value;}
                    );
                  },
                  child: Stack(
                      alignment: Alignment.center, // 堆叠位置方式
                      children: <Widget>[
                        Align( // 调整方位
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "铃声", style: _textStyleLarge,),
                              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            )
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Text(_alarmData.ringName,
                                style: _textStyleLarge,
                                overflow: TextOverflow.ellipsis, //文本过长时的显示方式
                                maxLines: 1,),
                              padding: EdgeInsets.fromLTRB(120, 0, 25, 0),
                            )
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Icon(Icons.arrow_forward_ios,size: 16,color: Colors.black,),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            )
                        ),
                      ]
                  )
              );
            }
        )
    );
  }

  // 振动
  _vibration(){
    return Container(
        height: 50.0,
        child: Builder(
            builder:(BuildContext context){
              return InkWell(
                  onTap: (){
                    (context as Element).markNeedsBuild();
                    _alarmData.vibration=!_alarmData.vibration;
                  },
                  child: Stack(
                      alignment: Alignment.center, // 堆叠位置方式
                      children: <Widget>[
                        Align( // 调整方位
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "振动", style: _textStyleLarge,),
                              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            )
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child:Switch(
                              value: _alarmData.vibration,//当前状态
                              onChanged:(value){//重新构建页面
                                setState(() {_alarmData.vibration=value;});
                              },
                            ),
                        ),
                      ]
                  )
              );
            }
        )
    );
  }

  // 闹钟名
  _alarmName(){
    String tempName =  _alarmData.name;
    _getAlarmNameDialog(){
      bool _withTree = false;
      return showDialog<bool>(
//        barrierColor: Color.fromRGBO(255, 255, 255, 0.25),
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.85),
            title: Text("闹钟名",style: _textStyleLarge,),
            content: TextField(
              controller: TextEditingController(text: _alarmData.name),
              onChanged: (value){
                tempName = value;
              },
            ),
            actions: <Widget>[

              FlatButton(
                child: Text("取消",style: _textStyleSmall,),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Divider(),
              FlatButton(
                child: Text("确定",style: _textStyleSmall),
                onPressed: () {
                  _alarmData.name = tempName;
                  Navigator.of(context).pop(_withTree);
                },
              ),
            ],
          );
        },
      );
    }
    return Container(
        height: 50.0,
        child: Builder(
            builder:(BuildContext context){
              return InkWell(
                  onTap: (){
                    _getAlarmNameDialog().then((value){
                      (context as Element).markNeedsBuild();
                    });
                  },
                  child: Stack(
                      alignment: Alignment.center, // 堆叠位置方式
                      children: <Widget>[
                        Align( // 调整方位
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "闹钟名", style: _textStyleLarge,),
                              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            )
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Text(_alarmData.name,
                                style: _textStyleLarge,
                                overflow: TextOverflow.ellipsis, //文本过长时的显示方式
                                maxLines: 1,),
                              padding: EdgeInsets.fromLTRB(120, 0, 25, 0),
                            )
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Icon(Icons.arrow_forward_ios,size: 16,color: Colors.black,),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            )
                        ),
                      ]
                  )
              );
            }
        )
    );
  }

  // 响铃时长
  _ringTime(){
    _ringTimeDialog(){
      return showModalBottomSheet<int>(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          backgroundColor:Color.fromRGBO(120, 160, 180, 1),
          barrierColor:Color.fromRGBO(0, 0, 0, 0.5),
          context: context,
          builder: (context){
            return Container(
              height: 150,
              padding: EdgeInsets.fromLTRB(20, 10, 10, 10), //内边距
              child: ListView(
                children: <Widget>[
                  Text("响铃时长（分钟）",style: _textStyleLarge,),
                  Divider(),
                  SliderTheme( //自定义风格
                    data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.blue, //进度条滑块左边颜色
//                        inactiveTrackColor: Colors.blue, //进度条滑块右边颜色
                        //trackShape: RoundSliderTrackShape(radius: 10),//进度条形状,这边自定义两头显示圆角
                        thumbColor: Colors.white, //滑块颜色
                        overlayColor: Colors.green, //滑块拖拽时外圈的颜色
                        overlayShape: RoundSliderOverlayShape(//可继承SliderComponentShape自定义形状
                          overlayRadius: 10, //滑块外圈大小
                        ),
                        thumbShape: RoundSliderThumbShape(//可继承SliderComponentShape自定义形状
                          disabledThumbRadius: 12, //禁用是滑块大小
                          enabledThumbRadius: 12, //滑块大小
                        ),
                        inactiveTickMarkColor: Colors.black,
                        tickMarkShape: RoundSliderTickMarkShape(//继承SliderTickMarkShape可自定义刻度形状
                          tickMarkRadius: 5.0,//刻度大小
                        ),
                        showValueIndicator: ShowValueIndicator.onlyForDiscrete,//气泡显示的形式
                        valueIndicatorColor: Colors.cyan,//气泡颜色
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),//气泡形状
                        valueIndicatorTextStyle: TextStyle(color: Colors.black),//气泡里值的风格
                        trackHeight: 10 //进度条宽度
                    ),
                    child: Builder(
                      builder:(BuildContext context) {
                        return Slider(
                          value: _alarmData.ringTime.toDouble(),
                          onChanged: (v) {
                            (context as Element).markNeedsBuild();
                            if(v.toInt()==0)v++;
                            _alarmData.ringTime = v.toInt();
                          },
                          label: "${_alarmData.ringTime}分钟", //气泡的值
                          divisions: 6, //进度条上显示多少个刻度点
                          max: 30,
                          min: 0,
                        );
                      }
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 15, 10),
                    child: Row(
                      children: [
                        Text(" 1",),
                        Text(" 5",),
                        Text("10",),
                        Text("15",),
                        Text("20",),
                        Text("25",),
                        Text("30",),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, //水平轴显示方式
                      crossAxisAlignment: CrossAxisAlignment.center, //在外层盒子里的位置
                    ),
                  ),
//                  Text("    1             5             10            15            20            25            30")
                ],
              ),
            );
          }
      );
    }

    return Container(
        height: 50.0,
        child: Builder(
            builder:(BuildContext context){
              return InkWell(
                  onTap: (){
                    _ringTimeDialog().then((value){
                      (context as Element).markNeedsBuild();
                      }
                    );
                  },
                  child: Stack(
                      alignment: Alignment.center, // 堆叠位置方式
                      children: <Widget>[
                        Align( // 调整方位
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "响铃时长", style: _textStyleLarge,),
                              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            )
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Text(_alarmData.transRingTime2Str(), style: _textStyleLarge),
                              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                            )
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Icon(Icons.arrow_forward_ios,size: 16,color: Colors.black,),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            )
                        ),
                      ]
                  )
              );
            }
        )
    );
  }

  // 再响间隔
  _ringInterval(){
    _ringIntervalDialog(){
      return showModalBottomSheet<int>(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          backgroundColor:Color.fromRGBO(120, 160, 180, 1),
          barrierColor:Color.fromRGBO(0, 0, 0, 0.5),
          context: context,
          builder: (context){
            return Container(
              height: 300,
              padding: EdgeInsets.fromLTRB(20, 10, 10, 10), //内边距
              child: ListView(
                children: <Widget>[
                  Text("再响间隔",style: _textStyleLarge,),
                  Divider(),

                  Text("响铃间隔时间（分钟）",style: TextStyle(fontSize: 18),),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                  SliderTheme( //自定义风格
                      data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.blue, //进度条滑块左边颜色
//                        inactiveTrackColor: Colors.blue, //进度条滑块右边颜色
                          //trackShape: RoundSliderTrackShape(radius: 10),//进度条形状,这边自定义两头显示圆角
                          thumbColor: Colors.white, //滑块颜色
                          overlayColor: Colors.green, //滑块拖拽时外圈的颜色
                          overlayShape: RoundSliderOverlayShape(//可继承SliderComponentShape自定义形状
                            overlayRadius: 10, //滑块外圈大小
                          ),
                          thumbShape: RoundSliderThumbShape(//可继承SliderComponentShape自定义形状
                            disabledThumbRadius: 12, //禁用是滑块大小
                            enabledThumbRadius: 12, //滑块大小
                          ),
                          inactiveTickMarkColor: Colors.black,
                          tickMarkShape: RoundSliderTickMarkShape(//继承SliderTickMarkShape可自定义刻度形状
                            tickMarkRadius: 5.0,//刻度大小
                          ),
                          showValueIndicator: ShowValueIndicator.onlyForDiscrete,//气泡显示的形式
                          valueIndicatorColor: Colors.cyan,//气泡颜色
                          valueIndicatorShape: PaddleSliderValueIndicatorShape(),//气泡形状
                          valueIndicatorTextStyle: TextStyle(color: Colors.black),//气泡里值的风格
                          trackHeight: 10 //进度条宽度
                      ),
                      child: Builder(
                          builder:(BuildContext context) {
                            return Slider(
                              value: _alarmData.ringInterval.toDouble(),
                              onChanged: (v) {
                                (context as Element).markNeedsBuild();
                                _alarmData.ringInterval = v.toInt();
                              },
                              label: "${_alarmData.ringInterval}分钟", //气泡的值
                              divisions: 5, //进度条上显示多少个刻度点
                              max: 30,
                              min: 5,
                            );
                          }
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 15, 10),
                    child: Row(
                      children: [
                        Text(" 5",),
                        Text("10",),
                        Text("15",),
                        Text("20",),
                        Text("25",),
                        Text("30",),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, //水平轴显示方式
                      crossAxisAlignment: CrossAxisAlignment.center, //在外层盒子里的位置
                    ),
                  ),

//                  Text("    5               10               15               20               25               30"),
                  Divider(),

                  Text("重复响铃次数",style: TextStyle(fontSize: 18),),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                  SliderTheme( //自定义风格
                      data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.blue, //进度条滑块左边颜色
//                        inactiveTrackColor: Colors.blue, //进度条滑块右边颜色
                          //trackShape: RoundSliderTrackShape(radius: 10),//进度条形状,这边自定义两头显示圆角
                          thumbColor: Colors.white, //滑块颜色
                          overlayColor: Colors.green, //滑块拖拽时外圈的颜色
                          overlayShape: RoundSliderOverlayShape(//可继承SliderComponentShape自定义形状
                            overlayRadius: 10, //滑块外圈大小
                          ),
                          thumbShape: RoundSliderThumbShape(//可继承SliderComponentShape自定义形状
                            disabledThumbRadius: 12, //禁用是滑块大小
                            enabledThumbRadius: 12, //滑块大小
                          ),
                          inactiveTickMarkColor: Colors.black,
                          tickMarkShape: RoundSliderTickMarkShape(//继承SliderTickMarkShape可自定义刻度形状
                            tickMarkRadius: 2.0,//刻度大小
                          ),
                          showValueIndicator: ShowValueIndicator.onlyForDiscrete,//气泡显示的形式
                          valueIndicatorColor: Colors.cyan,//气泡颜色
                          valueIndicatorShape: PaddleSliderValueIndicatorShape(),//气泡形状
                          valueIndicatorTextStyle: TextStyle(color: Colors.black),//气泡里值的风格
                          trackHeight: 10 //进度条宽度
                      ),
                      child: Builder(
                          builder:(BuildContext context) {
                            (context as Element).markNeedsBuild();
                            return Slider(
                              value: _alarmData.ringFrequency.toDouble(),
                              onChanged: (v) {
                                (context as Element).markNeedsBuild();
                                _alarmData.ringFrequency = v.toInt();
                              },
                              label: "${_alarmData.ringFrequency}次", //气泡的值
                              divisions: 8, //进度条上显示多少个刻度点
                              max: 9,
                              min: 1,
                            );
                          }
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 15, 10),
                    child: Row(
                      children: [
                        Text(" 1",),
                        Text(" 5",),
                        Text(" 9",),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, //水平轴显示方式
                      crossAxisAlignment: CrossAxisAlignment.center, //在外层盒子里的位置
                    ),
                  ),
//                  Text("    1                                        5                                                   10"),
                  Divider(),
                ],
              ),
            );
          }
      );
    }

    return Container(
        height: 50.0,
        child: Builder(
            builder:(BuildContext context){
              return InkWell(
                  onTap: (){
                    _ringIntervalDialog().then((value){
                      (context as Element).markNeedsBuild();
                    }
                    );
                  },
                  child: Stack(
                      alignment: Alignment.center, // 堆叠位置方式
                      children: <Widget>[
                        Align( // 调整方位
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "再响间隔", style: _textStyleLarge,),
                              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            )
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Text(_alarmData.transRingFrequency2Str(), style: _textStyleLarge),
                              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                            )
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Icon(Icons.arrow_forward_ios,size: 16,color: Colors.black,),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            )
                        ),
                      ]
                  )
              );
            }
        )
    );
  }
}
