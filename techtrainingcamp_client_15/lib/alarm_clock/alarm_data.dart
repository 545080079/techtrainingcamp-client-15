import 'dart:convert';
/*
 闹钟所有数据
 */

class AlarmData{
  String alarmID = DateTime.now().toString(); // 闹钟编号,用创建时间当编号
  bool isOpen = true; //是否打开
  DateTime time = DateTime.now(); // 闹钟时间

  Map<String,bool> repeat ={
    "周一":false,
    "周二":false,
    "周三":false,
    "周四":false,
    "周五":false,
    "周六":false,
    "周日":false,
  };
  String ringName = "lemon";         // 铃声
  String ringUrl = '1.mp3';
  bool vibration = false;   // 振动
  String name = "闹钟";     // 闹钟名
  int ringTime = 5;        // 响铃时长 1,5,10,15,20,30
  int ringInterval = 5;    // 响铃间隔 1,5,10,15,20,30
  int ringFrequency = 1;    // 响铃重复次数，1，3,5,10

  AlarmData();
  setAlarmByOther(AlarmData other){
    this.alarmID = other.alarmID;
    this.isOpen = other.isOpen;
    this.time = other.time;
    this.repeat = other.repeat;
    this.ringName = other.ringName;
    this.ringUrl = other.ringUrl;
    this.vibration = other.vibration;
    this.name = other.name;
    this.ringTime = other.ringTime;
    this.ringInterval = other.ringInterval;
    this.ringFrequency = other.ringFrequency;
  }
  // 从stringList加载AlarmData；本地存储恢复
  AlarmData.fromStringList(List<String> stringList){
    int i=0;
//    this.alarmID = DateTime.parse(stringList[i++]);
    this.alarmID = stringList[i++];

    int temp = int.parse(stringList[i++]);
    this.isOpen = temp==1?true:false;

    this.time = DateTime.parse(stringList[i++]);

    Map<String, dynamic> tempMap = json.decode(stringList[i++]);
    tempMap.forEach((key, value) {
      this.repeat[key] = value;
    });

    this.ringName = stringList[i++];
    this.ringUrl = stringList[i++];
    int temp2 = int.parse(stringList[i++]);
    this.vibration = temp2==1?true:false;
    this.name = stringList[i++];     // 闹钟名
    this.ringTime = int.parse(stringList[i++]);
    this.ringInterval = int.parse(stringList[i++]);
    this.ringFrequency = int.parse(stringList[i++]);

  }
  // 将重复日转换为String
  String transRepeat2Str(){
    String res = "";
    bool flag = false;
    repeat.forEach((key, value) {
      if(value){
        res = res+key+",";
        flag=true;
      }
    });
    if(!flag){
      res = "无重复";
    }
    else{
      res = res.substring(0,res.length-1);
    }
    return res;
  }

  String transRingTime2Str(){
    return ringTime.toString()+" 分钟";
  }

  String transRingFrequency2Str(){
    return ringInterval.toString()+"分钟,"+ringFrequency.toString()+"次";
  }

  // 将所有数据转换为List<String>
  List<String> transAll2Str(){
    List<String> alarmStrList = [];
    alarmStrList.add(this.alarmID);
    alarmStrList.add((this.isOpen?1:0).toString());
//    DateTime temp = DateTime(2020,1,1,this.time.hour,this.time.minute);
    alarmStrList.add(time.toString());
    alarmStrList.add(json.encode(this.repeat));
    alarmStrList.add(this.ringName);
    alarmStrList.add(this.ringUrl);
    alarmStrList.add((this.vibration?1:0).toString());
    alarmStrList.add(this.name);
    alarmStrList.add(this.ringTime.toString());
    alarmStrList.add(this.ringInterval.toString());
    alarmStrList.add(this.ringFrequency.toString());

    return alarmStrList;
  }

  // int星期转换String
  static String getWeekdayStr(DateTime time) {
    switch (time.weekday) {
      case 1: return "周一";
      case 2: return "周二";
      case 3: return "周三";
      case 4: return "周四";
      case 5: return "周五";
      case 6: return "周六";
      case 7: return "周日";
      default:return "周一";
    }
  }
}