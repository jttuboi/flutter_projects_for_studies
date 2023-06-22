import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/todos/blocs/blocs.dart';
import 'package:todos/todos/models/models.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  FilteredTodosBloc({required this.todosBloc})
      : super(
          todosBloc.state is TodosLoadSuccess
              ? FilteredTodosLoadSuccess(filteredTodos: (todosBloc.state as TodosLoadSuccess).todos, currentFilter: VisibilityFilter.all)
              : FilteredTodosLoadInProgress(),
        ) {
    on<FilterUpdated>(_onFilterUpdated);
    on<TodosUpdated>(_onTodosUpdated);

    // cria um listener do todosBloc.
    // Quando o stream do todoBloc é atualizado, esse listener é chamado.
    // Se os todos foram recuperados, chama o evento para atualizar os todos de acordo com o filtro.
    todosSubscription = todosBloc.stream.listen((state) {
      if (state is TodosLoadSuccess) {
        add(TodosUpdated((todosBloc.state as TodosLoadSuccess).todos));
      }
    });
  }

  final TodosBloc todosBloc;
  late final StreamSubscription todosSubscription;

  Future<void> _onFilterUpdated(FilterUpdated event, Emitter<FilteredTodosState> emit) async {
    if (todosBloc.state is TodosLoadSuccess) {
      final getFilteredTodos = _getFilteredTodos((todosBloc.state as TodosLoadSuccess).todos, event.filter);
      emit(FilteredTodosLoadSuccess(filteredTodos: getFilteredTodos, currentFilter: event.filter));
    }
  }

  Future<void> _onTodosUpdated(TodosUpdated event, Emitter<FilteredTodosState> emit) async {
    final filter = state is FilteredTodosLoadSuccess ? (state as FilteredTodosLoadSuccess).currentFilter : VisibilityFilter.all;
    final getFilteredTodos = _getFilteredTodos((todosBloc.state as TodosLoadSuccess).todos, filter);
    emit(FilteredTodosLoadSuccess(filteredTodos: getFilteredTodos, currentFilter: filter));
  }

  List<Todo> _getFilteredTodos(List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter.isAll) {
        return true;
      } else if (filter.isActive) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
