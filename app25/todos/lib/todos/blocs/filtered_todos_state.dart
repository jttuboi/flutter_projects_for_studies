part of 'filtered_todos_bloc.dart';

abstract class FilteredTodosState extends Equatable {
  const FilteredTodosState();

  @override
  List<Object> get props => [];
}

class FilteredTodosLoadInProgress extends FilteredTodosState {
  @override
  String toString() => 'FilteredTodosLoadInProgress()';
}

class FilteredTodosLoadSuccess extends FilteredTodosState {
  const FilteredTodosLoadSuccess({
    required this.filteredTodos,
    required this.currentFilter,
  });

  final List<Todo> filteredTodos;
  final VisibilityFilter currentFilter;

  @override
  List<Object> get props => [filteredTodos, currentFilter];

  @override
  String toString() => 'FilteredTodosLoadSuccess($filteredTodos, $currentFilter)';
}
