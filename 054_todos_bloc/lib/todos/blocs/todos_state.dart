part of 'todos_bloc.dart';

class TodosState extends Equatable {
  const TodosState({
    this.todos = const <Todo>[],
    this.showStatus = ShowStatus.allTodos,
  });

  final List<Todo> todos;
  final ShowStatus showStatus;

  @override
  List<Object> get props => [todos, showStatus];

  TodosState copyWith({
    List<Todo>? todos,
    ShowStatus? showStatus,
  }) {
    return TodosState(
      todos: todos ?? this.todos,
      showStatus: showStatus ?? this.showStatus,
    );
  }
}
