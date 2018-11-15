import 'dart:math';

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final double width;
  final List<double> percents;
  final List<Color> colors;
  final StrokeCap lineStrokeCap;

  Paint _line;

  MyPainter(this.colors, this.percents, this.width, this.lineStrokeCap) {
    assert(colors.length == percents.length);
    _line = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - width / 2;
    var rect = new Rect.fromCircle(center: center, radius: radius);
    canvas.drawCircle(center, radius, _line);

    Map<int, MapEntry<double, double>> map = Map();

    var startAngle = -pi / 2;
    percents.asMap().forEach((index, percent) {
      var angle = _getAngle(percent);
      map[index] = MapEntry(startAngle, angle);
      startAngle += angle;
    });

    map.values.toList().reversed.toList().asMap().forEach((index, mapEntry) {
      canvas.drawArc(
          rect, mapEntry.key, mapEntry.value, false, _getColorLine(index));
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double _getAngle(double percent) {
    return 2 * pi * (percent / 100);
  }

  Paint _getColorLine(int index) {
    return new Paint()
      ..color = colors[index]
      ..strokeCap = lineStrokeCap
      ..strokeJoin = StrokeJoin.round
      ..strokeMiterLimit = 1000.0
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
  }
}
