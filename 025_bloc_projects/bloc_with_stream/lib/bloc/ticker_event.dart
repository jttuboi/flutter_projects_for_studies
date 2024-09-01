part of 'ticker_bloc.dart';

abstract class TickerEvent extends Equatable {
  const TickerEvent();

  @override
  List<Object> get props => [];
}

class TickerStarted extends TickerEvent {
  const TickerStarted();
}

class _TickerTicked extends TickerEvent {
  const _TickerTicked(this.tick);

  final int tick;

  @override
  List<Object> get props => [tick];
}
