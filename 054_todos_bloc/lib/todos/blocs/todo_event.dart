part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoDeleted extends TodoEvent {}

class TodoUpdated extends TodoEvent {
  const TodoUpdated({required this.todo});

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

class TodoChecked extends TodoEvent {
  const TodoChecked({required this.isCompleted});

  final bool isCompleted;

  @override
  List<Object> get props => [isCompleted];
}

class TodoSaved extends TodoEvent {
  const TodoSaved({required this.todo});

  final Todo todo;

  @override
  List<Object> get props => [todo];
}
