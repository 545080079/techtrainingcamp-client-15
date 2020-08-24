import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'dart:math' as math;

final radiansPerTick = radians(360 / 60);

final radiusClock = 160.0;

class BackgroundView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CustomPaint(
          painter: ViewPainter(
              radius: radiusClock
          ),
        ),
      ),
    );
  }
}



class ViewPainter extends CustomPainter{

  ViewPainter({
    @required this.radius,
  })  : assert(radius != null);

  double radius;




  @override
  void paint(Canvas canvas, Size size) {


    //大刻度画笔
    final axisPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3;

    //十二刻度画笔
    final axis12Paint = Paint()
      ..color = Colors.lightBlueAccent
      ..strokeWidth = 3;


    //六十刻度画笔
    final axis60Paint = Paint()
      ..color = Colors.lightBlue
      ..strokeWidth = 3;

    //canvas.drawImage(image: 'images_b1_sunny.gif', Offset(0, 0), bgPaint);

//    canvas.drawShadow(
//        Path()
//          ..moveTo(-180.0, -270.0)..lineTo(150.0, -270.0)
//          ..lineTo(150.0, 100.0)..lineTo(-180.0, 100.0)
//          ..close(),
//        Colors.yellow, 55, true);



    //canvas.drawCircle(new Offset(0, 0), radius, circlePaint);

    //大刻度
    canvas.drawLine(new Offset(0, -radiusClock), new Offset(0, -radiusClock + 20), axisPaint);
    canvas.drawLine(new Offset(-radiusClock, 0), new Offset(-radiusClock + 20, 0), axisPaint);
    canvas.drawLine(new Offset(0, radiusClock), new Offset(0, radiusClock - 20), axisPaint);
    canvas.drawLine(new Offset(radiusClock, 0), new Offset(radiusClock - 20, 0), axisPaint);

    final center = (Offset.zero & size).center;

    //每60度为一圈，60 / 12 = 5，每隔5画一根刻度
    var cur = 0;
    var angleRadians = cur * radiansPerTick;
    var angle = angleRadians - math.pi;
    var positionStart = center + Offset(math.cos(angle), math.sin(angle)) * (radiusClock - 10);
    var positionEnd = center + Offset(math.cos(angle), math.sin(angle)) * radiusClock;

    //十二刻度
    while (cur < 60) {
      if(cur % 15 != 0) {
        if ((cur & 1) == 1 && flagRepaint)
          canvas.drawLine(positionStart, positionEnd, axis12Paint);
        else if ((cur & 1) == 0 && !flagRepaint)
          canvas.drawLine(positionStart, positionEnd, axis12Paint);
      }
      cur += 5;
      angleRadians = cur * radiansPerTick;
      angle = angleRadians - math.pi;
      positionStart = center + Offset(math.cos(angle), math.sin(angle)) * (radiusClock - 10);
      positionEnd = center + Offset(math.cos(angle), math.sin(angle)) * radiusClock;
    }

    //六十刻度
    cur = 0;
    while (cur < 60) {
      if(cur % 15 != 0 && cur % 5 != 0) {
        if ((cur & 1) == 1 && flagRepaint)
          canvas.drawLine(positionStart, positionEnd, axis60Paint);
        else if ((cur & 1) == 0 && !flagRepaint)
          canvas.drawLine(positionStart, positionEnd, axis60Paint);
      }
      cur += 1;
      angleRadians = cur * radiansPerTick;
      angle = angleRadians - math.pi;
      positionStart = center + Offset(math.cos(angle), math.sin(angle)) * (radiusClock - 5);
      positionEnd = center + Offset(math.cos(angle), math.sin(angle)) * radiusClock;
    }
  }

  static var flagRepaint = false;
  @override
  bool shouldRepaint(ViewPainter oldDelegate) {
    return flagRepaint;
  }
}