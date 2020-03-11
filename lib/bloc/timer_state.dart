abstract class TimerState {
  final int progress;

  const TimerState(this.progress);
}

class Ready extends TimerState {
  const Ready(int duration) : super(duration);

  @override
  String toString() => 'Ready { progress: $progress }';
}

class Running extends TimerState {
  const Running(int duration) : super(duration);

  @override
  String toString() => 'Running { progress: $progress }';
}

class Finished extends TimerState {
  const Finished() : super(0);
}
