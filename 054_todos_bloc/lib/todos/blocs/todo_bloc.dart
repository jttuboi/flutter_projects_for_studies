import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_bloc/todos/todos.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required ITodoRepository todoRepository, required Todo todo})
      : _todoRepository = todoRepository,
        super(TodoState(todo: todo)) {
    on<TodoDeleted>(_onTodoDeleted);
    on<TodoChecked>(_onTodoChecked);
    on<TodoUpdated>(_onTodoUpdated);
    on<TodoSaved>(_onTodoSaved);
  }

  final ITodoRepository _todoRepository;

  Future<void> _onTodoDeleted(TodoDeleted event, Emitter<TodoState> emit) async {
    await _todoRepository.deleteTodo(state.todo);
  }

  Future<void> _onTodoChecked(TodoChecked event, Emitter<TodoState> emit) async {
    await _todoRepository.checkTodo(state.todo, event.isCompleted);
    emit(state.copyWith(todo: state.todo.copyWith(completed: event.isCompleted)));
  }

  Future<void> _onTodoUpdated(TodoUpdated event, Emitter<TodoState> emit) async {
    emit(state.copyWith(todo: event.todo));
  }

  Future<void> _onTodoSaved(TodoSaved event, Emitter<TodoState> emit) async {
    await _todoRepository.saveTodo(event.todo);
    emit(state.copyWith(todo: event.todo));
  }
}
