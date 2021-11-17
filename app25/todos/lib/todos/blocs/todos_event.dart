part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class TodosLoaded extends TodosEvent {
  const TodosLoaded();

  @override
  String toString() => 'TodosLoaded()';
}

class TodoAdded extends TodosEvent {
  const TodoAdded(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoAdded($todo)';
}

class TodoUpdated extends TodosEvent {
  const TodoUpdated(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoUpdated($todo)';
}

class TodoDeleted extends TodosEvent {
  const TodoDeleted(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'TodoDeleted($todo)';
}

class ClearCompleted extends TodosEvent {
  @override
  String toString() => 'ClearCompleted()';
}

class ToggleAll extends TodosEvent {
  @override
  String toString() => 'ToggleAll()';
}
