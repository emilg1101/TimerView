import 'dart:async';

class Ticker {
  StreamController<int> _controller;
  Timer _timer;

  Stream<int> tick(int counter) {
    if (_controller != null) {
      _controller.close();
    }
    if (_timer != null) {
      _timer.cancel();
    }
    _controller = StreamController<int>();
    void tick(Timer timer) {
      counter++;
      if (counter >= 86400) {
        counter = 1;
      }
      if (!_controller.isClosed) {
        _controller.add(counter);
      }
    }

    _timer = Timer.periodic(Duration(seconds: 1), tick);
    return _controller.stream;
  }
}
