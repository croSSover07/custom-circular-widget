import 'dart:math';

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  double width;
  List<double> percents;
  Paint _line;
  var _random = new Random();

  MyPainter({this.percents, this.width}) {
    _line = new Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
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
      ..color = _randomColor()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
  }

  Color _randomColor(){
    var a = 255; // alpha = 0..255
    var r = _random.nextInt(256); // red = 0..255
    var g = _random.nextInt(256); // green = 0..255
    var b = _random.nextInt(256); // blue = 0..255
    return Color.fromARGB(a, r, g, b);
  }
}
