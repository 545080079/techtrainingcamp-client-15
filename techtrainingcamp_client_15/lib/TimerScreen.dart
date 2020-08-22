import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class TimerScreen extends StatefulWidget {
  @override
  _TimerScreen createState() => _TimerScreen();
}

class _TimerScreen extends State<TimerScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    _showTimePicker() async {
      var res = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
      );

      setState(() {
        this._selectedTime = res;
        print(_selectedTime.format(context));
      });

    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _showTimePicker();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (_selectedTime != null)
                      Text(_selectedTime.format(context))
                    else
                      Text(TimeOfDay.now().format(context)),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              Center(
                child: RaisedButton(
                  onPressed: showNotification,
                  child: Text(
                    '设定',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var init = InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(init, onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Notification'),
        content: Text('$payload'),
      ),
    );
  }

  showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    int _time = _selectedTime.hour * 60 + _selectedTime.minute - DateTime.now().minute - DateTime.now().hour * 60;
    if(_time < 0)
      _time = 1;
    _time *= 60;
    print('Your selected _time = ' + _time.toString());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {

      if(_time == 0 || (_time < 58 && DateTime.now().second < 2)) {
        await flutterLocalNotificationsPlugin.show(
            0, '通知', '定时器时间到', platform,
            payload: '您预订滴时间到了');
        print('display notification.');
        _timer.cancel();
        return;
      }
      setState(() {
        _time--;

      });
    });


  }
}
