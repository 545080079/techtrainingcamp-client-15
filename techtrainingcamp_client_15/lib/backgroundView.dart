

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'dart:math' as math;

final radiansPerTick = radians(360 / 60);

class BackgroundView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CustomPaint(
            painter: ViewPainter(
                radius: 190
            ),
          ),
        ],
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

    //时钟画笔
    final circlePaint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.square;

    //大刻度画笔
    final axisPaint = Paint()
      ..color = Colors.tealAccent
      ..strokeWidth = 3;

    //十二刻度画笔
    final axis12Paint = Paint()
      ..color = Colors.tealAccent.shade400
      ..strokeWidth = 3;


    //六十刻度画笔
    final axis60Paint = Paint()
      ..color = Colors.tealAccent.shade700
      ..strokeWidth = 3;

    canvas.drawCircle(new Offset(0, 0), radius, circlePaint);

    //大刻度
    canvas.drawLine(new Offset(0, -190), new Offset(0, -170), axisPaint);
    canvas.drawLine(new Offset(190, 0), new Offset(170, 0), axisPaint);
    canvas.drawLine(new Offset(0, 190), new Offset(0, 170), axisPaint);
    canvas.drawLine(new Offset(-190, 0), new Offset(-170, 0), axisPaint);


    final center = (Offset.zero & size).center;

    //每60度为一圈，60 / 12 = 5，每隔5画一根刻度
    var cur = 0;
    var angleRadians = cur * radiansPerTick;
    var angle = angleRadians - math.pi;
    var positionStart = center + Offset(math.cos(angle), math.sin(angle)) * 180;
    var positionEnd = center + Offset(math.cos(angle), math.sin(angle)) * 190;

    //十二刻度
    while (cur < 60) {
      if(cur % 15 != 0)
        canvas.drawLine(positionStart, positionEnd, axis12Paint);
      cur += 5;
      angleRadians = cur * radiansPerTick;
      angle = angleRadians - math.pi;
      positionStart = center + Offset(math.cos(angle), math.sin(angle)) * 180;
      positionEnd = center + Offset(math.cos(angle), math.sin(angle)) * 190;
    }

    //六十刻度
    cur = 0;
    while (cur < 60) {
      if(cur % 15 != 0 && cur % 5 != 0)
        canvas.drawLine(positionStart, positionEnd, axis60Paint);
      cur += 1;
      angleRadians = cur * radiansPerTick;
      angle = angleRadians - math.pi;
      positionStart = center + Offset(math.cos(angle), math.sin(angle)) * 185;
      positionEnd = center + Offset(math.cos(angle), math.sin(angle)) * 190;
    }




  }

  @override
  bool shouldRepaint(ViewPainter oldDelegate) {
    return false;
  }
}