import 'package:flutter/foundation.dart';

abstract class TimerEvent {
  final int duration;

  const TimerEvent({@required this.duration});
}

class Start extends TimerEvent {
  final int duration;

  const Start({@required this.duration});

  @override
  String toString() => "Start { duration: $duration }";
}

class Tick extends TimerEvent {
  final int duration;

  const Tick({@required this.duration});

  @override
  String toString() => "Tick { duration: $duration }";
}

class Slide extends TimerEvent {
  final int duration;

  const Slide({@required this.duration});

  @override
  String toString() => "Slide { duration: $duration }";
}
