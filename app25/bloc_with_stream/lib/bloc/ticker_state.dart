part of 'ticker_bloc.dart';

abstract class TickerState extends Equatable {
  const TickerState();

  @override
  List<Object> get props => [];
}

class TickerInitial extends TickerState {}

class TickerTickSuccess extends TickerState {
  const TickerTickSuccess(this.count);

  final int count;

  @override
  List<Object> get props => [count];
}

class TickerComplete extends TickerState {
  const TickerComplete();
}
