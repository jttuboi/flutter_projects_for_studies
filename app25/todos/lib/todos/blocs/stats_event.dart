part of 'stats_bloc.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class StatsUpdated extends StatsEvent {
  const StatsUpdated(this.todos);

  final List<Todo> todos;

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'StatsLoadInProgress($todos)';
}
