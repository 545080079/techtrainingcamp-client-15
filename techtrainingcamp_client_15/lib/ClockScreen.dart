import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_clock_helper/model.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen(this.model);

  final ClockModel model;

  @override
  _ClockScreen createState() => _ClockScreen();
}

class _ClockScreen extends State<ClockScreen> {
  final myClockBuilder = (ClockModel model) => ClockScreen(model);
  var time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'clock',
      ),
      child: Container(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(time.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }

}