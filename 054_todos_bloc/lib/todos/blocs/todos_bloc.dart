import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_bloc/todos/todos.dart';

part 'todos_event.dart';
part 'todos_state.dart';

enum ShowStatus {
  allTodos,
  completeTodos,
  incompleteTodos,
}

extension ShowStatusExtension on ShowStatus {
  bool get showAllTodos => this == ShowStatus.allTodos;
  bool get showCompleteTodos => this == ShowStatus.completeTodos;
  bool get showIncompleteTodos => this == ShowStatus.incompleteTodos;
}

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({required ITodosRepository todosRepository})
      : _todosRepository = todosRepository,
        super(const TodosState()) {
    on<TodosTabOpened>(_onTodosTabOpened);
    on<ShowAllTodos>(_onShowAllTodos);
    on<ShowActiveTodos>(_onShowActiveTodos);
    on<ShowCompletedTodos>(_onShowCompletedTodos);
    on<TodoCheckedFromList>(_onTodoCheckedFromList);
    on<TodoDeletedFromList>(_onTodoDeletedFromList);
    on<TodoUndone>(_onTodoUndone);
    on<TodosUpdated>(_onTodosUpdated);
    on<TodoAdded>(_onTodoAdded);
  }

  final ITodosRepository _todosRepository;
  Todo _todoDeleted = Todo.empty;

  Future<void> _onTodosTabOpened(TodosTabOpened event, Emitter<TodosState> emit) async {
    final todos = await _todosRepository.getTodos();
    emit(state.copyWith(todos: todos));
  }

  Future<void> _onShowAllTodos(ShowAllTodos event, Emitter<TodosState> emit) async {
    final todos = await _todosRepository.getTodos();
    emit(state.copyWith(todos: todos, showStatus: ShowStatus.allTodos));
  }

  Future<void> _onShowActiveTodos(ShowActiveTodos event, Emitter<TodosState> emit) async {
    final activeTodos = await _todosRepository.getIncompleteTodos();
    emit(state.copyWith(todos: activeTodos, showStatus: ShowStatus.incompleteTodos));
  }

  Future<void> _onShowCompletedTodos(ShowCompletedTodos event, Emitter<TodosState> emit) async {
    final completeTodos = await _todosRepository.getCompleteTodos();
    emit(state.copyWith(todos: completeTodos, showStatus: ShowStatus.completeTodos));
  }

  Future<void> _onTodoCheckedFromList(TodoCheckedFromList event, Emitter<TodosState> emit) async {
    await _todosRepository.checkTodo(event.todo, event.isCompleted);
    await _updateStateBasedOnShowTodos(emit);
  }

  Future<void> _onTodoDeletedFromList(TodoDeletedFromList event, Emitter<TodosState> emit) async {
    _todoDeleted = event.todo;
    await _todosRepository.deleteTodo(_todoDeleted);
    await _updateStateBasedOnShowTodos(emit);
  }

  Future<void> _onTodoUndone(TodoUndone event, Emitter<TodosState> emit) async {
    if (_todoDeleted == Todo.empty) {
      return;
    }

    await _todosRepository.addTodo(_todoDeleted);
    _todoDeleted = Todo.empty;

    await _updateStateBasedOnShowTodos(emit);
  }

  Future<void> _onTodosUpdated(TodosUpdated event, Emitter<TodosState> emit) async {
    await _updateStateBasedOnShowTodos(emit);
  }

  Future<void> _onTodoAdded(TodoAdded event, Emitter<TodosState> emit) async {
    await _todosRepository.addTodo(event.todo);
    await _updateStateBasedOnShowTodos(emit);
  }

  Future<void> _updateStateBasedOnShowTodos(Emitter<TodosState> emit) async {
    if (state.showStatus.showAllTodos) {
      emit(state.copyWith(todos: await _todosRepository.getTodos()));
    } else if (state.showStatus.showCompleteTodos) {
      emit(state.copyWith(todos: await _todosRepository.getCompleteTodos()));
    } else if (state.showStatus.showIncompleteTodos) {
      emit(state.copyWith(todos: await _todosRepository.getIncompleteTodos()));
    }
  }
}
