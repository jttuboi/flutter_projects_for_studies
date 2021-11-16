part of 'filtered_todos_bloc.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();
}

class FilterUpdated extends FilteredTodosEvent {
  const FilterUpdated(this.filter);

  final VisibilityFilter filter;

  @override
  List<Object> get props => [filter];
  @override
  String toString() => 'FilterUpdated($filter)';
}

class TodosUpdated extends FilteredTodosEvent {
  const TodosUpdated(this.todos);

  final List<Todo> todos;

  @override
  List<Object> get props => [todos];
  @override
  String toString() => 'TodosUpdated($todos)';
}
