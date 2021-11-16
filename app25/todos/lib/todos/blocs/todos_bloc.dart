import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/todos/models/models.dart';
import 'package:todos/todos/repository/repository.dart';
import 'package:uuid/uuid.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({required this.todosRepository}) : super(TodosLoadInProgress()) {
    on<TodosLoaded>(_onTodosLoaded);
    on<TodoAdded>(_onTodoAdded);
    on<TodoUpdated>(_onTodoUpdated);
    on<TodoDeleted>(_onTodoDeleted);
    on<ToggleAll>(_onToggleAll);
    on<ClearCompleted>(_onClearCompleted);
  }

  final ITodosRepository todosRepository;

  Future<void> _onTodosLoaded(TodosLoaded event, Emitter<TodosState> emit) async {
    try {
      final todos = await todosRepository.loadTodos();
      emit(TodosLoadSuccess(todos.map((e) => Todo.fromEntity(e)).toList()));
      // ignore: avoid_catches_without_on_clauses
    } catch (e, s) {
      log('_onTodosLoaded', error: e, stackTrace: s);
      emit(TodosLoadFailure());
    }
  }

  Future<void> _onTodoAdded(TodoAdded event, Emitter<TodosState> emit) async {
    if (state is TodosLoadSuccess) {
      final todo = (event.todo.id.isNotEmpty) ? event.todo : event.todo.copyWith(id: const Uuid().v4());
      final updatedTodos = List<Todo>.from((state as TodosLoadSuccess).todos)..add(todo);
      emit(TodosLoadSuccess(updatedTodos));
      await _saveTodos(updatedTodos);
    }
  }

  Future<void> _onTodoUpdated(TodoUpdated event, Emitter<TodosState> emit) async {
    if (state is TodosLoadSuccess) {
      final todoModified = (event.todo.id.isNotEmpty) ? event.todo : event.todo.copyWith(id: const Uuid().v4());
      final updatedTodos = (state as TodosLoadSuccess).todos.map((todo) {
        return (todo.id == todoModified.id) ? todoModified : todo;
      }).toList();
      emit(TodosLoadSuccess(updatedTodos));
      await _saveTodos(updatedTodos);
    }
  }

  Future<void> _onTodoDeleted(TodoDeleted event, Emitter<TodosState> emit) async {
    if (state is TodosLoadSuccess) {
      final updatedTodos = (state as TodosLoadSuccess).todos.where((todo) => todo.id != event.todo.id).toList();
      emit(TodosLoadSuccess(updatedTodos));
      await _saveTodos(updatedTodos);
    }
  }

  Future<void> _onToggleAll(ToggleAll event, Emitter<TodosState> emit) async {
    if (state is TodosLoadSuccess) {
      final allComplete = (state as TodosLoadSuccess).todos.every((todo) => todo.complete);
      final updatedTodos = (state as TodosLoadSuccess).todos.map((todo) => todo.copyWith(complete: !allComplete)).toList();
      emit(TodosLoadSuccess(updatedTodos));
      await _saveTodos(updatedTodos);
    }
  }

  Future<void> _onClearCompleted(ClearCompleted event, Emitter<TodosState> emit) async {
    if (state is TodosLoadSuccess) {
      final updatedTodos = (state as TodosLoadSuccess).todos.where((todo) => !todo.complete).toList();
      emit(TodosLoadSuccess(updatedTodos));
      await _saveTodos(updatedTodos);
    }
  }

  Future<void> _saveTodos(List<Todo> todos) {
    return todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }
}
