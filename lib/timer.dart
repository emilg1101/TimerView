import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimerView extends StatelessWidget {
  final TextStyle timeStyle;
  final TextStyle dateStyle;
  final DateTime dateTime;
  final int progress;
  final double pointWidth;
  final double progressWidth;

  final _formatter = DateFormat("dd.MM.yyyy");

  TimerView(
      {this.timeStyle,
      this.dateStyle,
      this.dateTime,
      this.progress = 0,
      this.pointWidth = 16.0,
      this.progressWidth = 8.0});

  String _timeFormat() {
    var hours = progress ~/ 3600;
    var minutes = (progress - (hours * 3600)) ~/ 60;
    var seconds = progress - (hours * 3600) - (minutes * 60);

    var result = "";
    if (hours < 10) {
      result += "0";
    }
    result += hours.toString() + ":";
    if (minutes < 10) {
      result += "0";
    }
    result += minutes.toString() + ":";
    if (seconds < 10) {
      result += "0";
    }
    result += seconds.toString();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        child: CustomPaint(
          foregroundPainter: _ForegroundPainter(
              completeColor: Color.fromRGBO(244, 41, 161, 1),
              completePercent: progress * (100 / 86400),
              width: progressWidth,
              pointWidth: pointWidth),
          painter: _BackgroundPainter(width: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatter.format(dateTime),
                      style: dateStyle,
                    ),
                    Text(
                      _timeFormat(),
                      style: timeStyle,
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  double width;
  Paint _fillPaint;

  _BackgroundPainter({this.width}) {
    _fillPaint = new Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = width;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    Path oval = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius + 2));
    canvas.drawShadow(oval, Colors.black26, 2.0, true);
    canvas.drawCircle(center, radius, _fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _ForegroundPainter extends CustomPainter {
  Color completeColor;
  double completePercent;
  double width;
  double pointWidth;

  Paint complete;
  Paint point;
  Paint pointBackground;

  _ForegroundPainter(
      {this.completeColor, this.completePercent, this.width, this.pointWidth}) {
    complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    point = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    pointBackground = new Paint()
      ..color = completeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    double arcAngle = 2 * pi * (completePercent / 100);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);

    var x = (size.width / 2) + cos(arcAngle + (-pi / 2)) * radius;
    var y = (size.width / 2) + sin(arcAngle + (-pi / 2)) * radius;

    canvas.drawCircle(Offset(x, y), pointWidth / 2, point);
    canvas.drawCircle(Offset(x, y), pointWidth / 2, pointBackground);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
