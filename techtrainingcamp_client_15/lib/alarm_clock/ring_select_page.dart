import 'package:flutter/material.dart';
import 'alarm_data.dart';
import 'music_player.dart';

/*
闹钟铃声选择界面
 */
class RingManagerPage extends StatefulWidget{
  AlarmData _alarmData;
  RingManagerPage(this._alarmData,{Key key}):super(key:key);
  @override
  _RingManagerPage createState()=>_RingManagerPage(_alarmData);
}
class _RingManagerPage extends State<RingManagerPage> {
  AlarmData _alarmData;
  static MusicPlayer _player;
  final List _musicSelectList = [true,false,false,false,false,];
  final List _musicUrlList = ["1.mp3","2.mp3","3.mp3","4.mp3","5.mp3",];
  final List _musicNameList = ["lemon","告白气球","光年之外","恋爱循环","说了再见",];
  bool _nullBar=true; // 无音乐

  _RingManagerPage(this._alarmData){
    _player = new MusicPlayer(_alarmData.ringUrl);
    for(int i=0;i<_musicNameList.length;i++){
      if(_musicNameList[i]==_alarmData.ringName){
        _musicSelectList[i]=true;
        _nullBar=false;
      }
      else{
        _musicSelectList[i]=false;
      }
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    _player.stop();
  }
  @override
  void dispose() {
    super.dispose();
    _player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("选择铃声"),
          backgroundColor: Color.fromRGBO(241 , 180, 180, 0.85),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _player.stop();
                if(_nullBar){
                  _alarmData.ringName="无";
                  _alarmData.ringUrl="无";
                }
                else{
                  for(int i=0;i<_musicSelectList.length;i++){
                    if(_musicSelectList[i]){
                      _alarmData.ringName=_musicNameList[i];
                      _alarmData.ringUrl = _musicUrlList[i];
                    }
                  }
                }
                Navigator.of(context).pop(_alarmData);
              }
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10), //内边距
          alignment: Alignment.center, //内容位置
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage("images/sun.jpg"),
          fit: BoxFit.cover,),
          ),
          child: ListView(
              children: [
                _getNullBar(),
                Divider(),
                _getMusicBar(0),
                Divider(),
                _getMusicBar(1),
                Divider(),
                _getMusicBar(2),
                Divider(),
                _getMusicBar(3),
                Divider(),
                _getMusicBar(4),
                Divider(),
              ]
          ),
        )
    );
  }

  _getMusicBar(int index){
    return Container(
        height: 50.0,
        child: Builder(
            builder:(BuildContext context){
              return InkWell(
                  onTap: (){
                    setState(() {
                      _musicSelectList[index] = true;
                      for(int i=0;i<_musicSelectList.length;i++){
                        if(i==index)continue;
                        _musicSelectList[i]=false;
                      }
                      _nullBar=false;
                    });

                    _alarmData.ringUrl=_musicUrlList[index];
                    _player.changeMusic(_musicUrlList[index]);
                  },
                  child: Stack(
                      alignment: Alignment.center, // 堆叠位置方式
                      children: <Widget>[
                        Align( // 调整方位
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "${_musicNameList[index]}", style: TextStyle(fontSize: 20),),
                              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            )
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child:ClipOval(
                            child: Checkbox(
                              value: _musicSelectList[index],//当前状态
                              onChanged:(value){//重新构建页面
                                setState(() {
                                  _musicSelectList[index]=true;
                                  for(int i=0;i<_musicSelectList.length;i++){
                                    if(i==index)continue;
                                    _musicSelectList[i]=false;
                                  }
                                  _nullBar=false;

                                  if(value){
                                    _alarmData.ringUrl=_musicUrlList[index];
                                    _player.changeMusic(_musicUrlList[index]);
                                  }
                                });
                              },
                            ),
                          )
                        ),
                      ]
                  )
              );
            }
        )
    );

  }

  _getNullBar(){
    return Container(
        height: 50.0,
        child: Builder(
            builder:(BuildContext context){
              return InkWell(
                  onTap: (){
                    setState(() {
                      _nullBar = true;
                      for(int i=0;i<_musicSelectList.length;i++){
                        _musicSelectList[i]=false;
                      }
                    });
                    _player.stop();
                  },
                  child: Stack(
                      alignment: Alignment.center, // 堆叠位置方式
                      children: <Widget>[
                        Align( // 调整方位
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "无", style: TextStyle(fontSize: 20),),
                              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            )
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child:ClipOval(
                              child: Checkbox(
                                value: _nullBar,//当前状态
                                onChanged:(value){//重新构建页面
                                  setState(() {
                                    _nullBar=true;
                                    for(int i=0;i<_musicSelectList.length;i++){
                                      _musicSelectList[i]=false;
                                    }
                                    _player.stop();
                                  });
                                },
                              ),
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