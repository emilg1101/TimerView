import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertimer/bloc/timer_state.dart';
import 'package:fluttertimer/ticker.dart';
import 'package:fluttertimer/bloc/timer_event.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;

  StreamSubscription<int> _tickerSubscription;

  TimerBloc({Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  @override
  TimerState get initialState => Ready(0);

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is Start) {
      yield* _mapStartToState(event);
    } else if (event is Tick) {
      yield* _mapTickToState(event);
    } else if (event is Slide) {
      yield* _mapSlideToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<TimerState> _mapStartToState(Start start) async* {
    yield Running(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(start.duration)
        .listen((duration) => add(Tick(duration: duration)));
  }

  Stream<TimerState> _mapTickToState(Tick tick) async* {
    yield tick.duration >= 86400 ? Running(0) : Running(tick.duration);
  }

  Stream<TimerState> _mapSlideToState(Slide slide) async* {
    yield Running(slide.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(slide.duration)
        .listen((duration) => add(Tick(duration: duration)));
  }
}
