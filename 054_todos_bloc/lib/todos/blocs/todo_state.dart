part of 'todo_bloc.dart';

class TodoState extends Equatable {
  const TodoState({this.todo = Todo.empty});

  final Todo todo;

  @override
  List<Object> get props => [todo];

  TodoState copyWith({
    Todo? todo,
  }) {
    return TodoState(
      todo: todo ?? this.todo,
    );
  }
}
