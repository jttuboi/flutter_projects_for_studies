part of 'stats_bloc.dart';

class StatsState extends Equatable {
  const StatsState({
    this.completedTodosQuantity = '0',
    this.activeTodosQuantity = '0',
  });

  final String completedTodosQuantity;
  final String activeTodosQuantity;

  @override
  List<Object> get props => [completedTodosQuantity, activeTodosQuantity];

  StatsState copyWith({
    String? completedTodosQuantity,
    String? activeTodosQuantity,
  }) {
    return StatsState(
      completedTodosQuantity: completedTodosQuantity ?? this.completedTodosQuantity,
      activeTodosQuantity: activeTodosQuantity ?? this.activeTodosQuantity,
    );
  }
}
