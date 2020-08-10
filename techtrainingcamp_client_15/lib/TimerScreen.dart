import 'package:flutter/material.dart';


class TimerScreen extends StatefulWidget {
  @override
  _TimerScreen createState() => _TimerScreen();
}

class _TimerScreen extends State<TimerScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();

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
              )
            ],
          )
        ],
      ),
    );
  }
}
