part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  const TimerState(this.duration);

  final int duration;

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(int duration) : super(duration);

  @override
  String toString() => 'TimerInitial($duration)';
}

class TimerRunPause extends TimerState {
  const TimerRunPause(int duration) : super(duration);

  @override
  String toString() => 'TimerRunPause($duration)';
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int duration) : super(duration);

  @override
  String toString() => 'TimerRunInProgress($duration)';
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}
