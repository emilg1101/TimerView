import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertimer/timer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static TextStyle _timeStyle = TextStyle(
      fontSize: 33.0,
      color: Color.fromRGBO(244, 41, 161, 1),
      fontFamily: 'Ubuntu');
  static TextStyle _dateStyle = TextStyle(fontSize: 14.0);

  int _time = 0;

  _MyHomePageState() {
    startTimeout(1000);
  }

  static const timeout = const Duration(seconds: 1);
  static const ms = const Duration(milliseconds: 1);

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    setState(() {
      if (_time == 86400) {
        _time = 0;
      } else {
        _time++;
      }
    });
    startTimeout(1000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TimerView(
            timeStyle: _timeStyle,
            dateStyle: _dateStyle,
            dateTime: DateTime.now(),
            progress: _time,
          ),
          Slider(
            value: _time.toDouble(),
            min: 0,
            max: 86400,
            onChanged: (t) {
              setState(() {
                _time = t.toInt();
              });
            },
          )
        ],
      ),
    );
  }
}
