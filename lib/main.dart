import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertimer/ticker.dart';
import 'package:fluttertimer/timer.dart';
import 'package:fluttertimer/bloc/timer_bloc.dart';
import 'package:fluttertimer/bloc/timer_event.dart';
import 'package:fluttertimer/bloc/timer_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => TimerBloc(ticker: Ticker()),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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

  @override
  Widget build(BuildContext context) {
    final TimerBloc bloc = BlocProvider.of<TimerBloc>(context);
    bloc.add(Start(duration: 0));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
            return TimerView(
              timeStyle: _timeStyle,
              dateStyle: _dateStyle,
              dateTime: DateTime.now(),
              progress: state.progress,
            );
          }),
          BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
            return Slider(
              value: state.progress.toDouble(),
              min: 0,
              max: 86400,
              onChanged: (t) {
                bloc.add(Slide(duration: t.toInt()));
              },
            );
          })
        ],
      ),
    );
  }
}
