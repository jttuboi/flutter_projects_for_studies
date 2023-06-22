part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosLoadSuccess extends TodosState {
  const TodosLoadSuccess([this.todos = const []]);

  final List<Todo> todos;

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosLoadSuccess($todos)';
}

class TodosLoadInProgress extends TodosState {
  @override
  String toString() => 'TodosLoadInProgress()';
}

class TodosLoadFailure extends TodosState {
  @override
  String toString() => 'TodosLoadFailure()';
}
