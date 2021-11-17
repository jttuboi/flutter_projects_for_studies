// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/todos/todos.dart';

import '../../mocks.dart';
import '../../support.dart';

void main() {
  late TodosBloc todosBloc;

  setUp(() {
    todosBloc = MockTodosBloc();
  });

  setUpAll(() {
    registerFallbackValue(TodosLoadInProgress());
    registerFallbackValue(TodosLoadSuccess());
    registerFallbackValue(TodosLoaded());
  });

  group('FilteredTodosBloc', () {
    blocTest<FilteredTodosBloc, FilteredTodosState>(
      'emits TodosLoaded when TodosUpdated is added',
      build: () {
        when(() => todosBloc.state).thenReturn(TodosLoadSuccess(todos));
        whenListen(todosBloc, Stream<TodosState>.fromIterable([TodosLoadSuccess(todos)]));
        return FilteredTodosBloc(todosBloc: todosBloc);
      },
      expect: () => <FilteredTodosState>[
        FilteredTodosLoadSuccess(filteredTodos: todos, currentFilter: VisibilityFilter.all),
      ],
    );

    blocTest<FilteredTodosBloc, FilteredTodosState>(
      'emits TodosLoaded when FilterUpdated is added with VisibilityFilter.active',
      build: () {
        when(() => todosBloc.state).thenReturn(TodosLoadSuccess(todosRandomComplete.clone()));
        whenListen(todosBloc, Stream<TodosState>.fromIterable([TodosLoadSuccess(todosRandomComplete.clone())]));
        return FilteredTodosBloc(todosBloc: todosBloc);
      },
      act: (bloc) => bloc.add(FilterUpdated(VisibilityFilter.active)),
      expect: () => <FilteredTodosState>[
        FilteredTodosLoadSuccess(filteredTodos: todosRandomCompleteOnlyActive, currentFilter: VisibilityFilter.active),
      ],
    );

    blocTest<FilteredTodosBloc, FilteredTodosState>(
      'emits TodosLoaded when FilterUpdated is added with VisibilityFilter.completed',
      build: () {
        when(() => todosBloc.state).thenReturn(TodosLoadSuccess(todosRandomComplete.clone()));
        whenListen(todosBloc, Stream<TodosState>.fromIterable([TodosLoadSuccess(todosRandomComplete.clone())]));
        return FilteredTodosBloc(todosBloc: todosBloc);
      },
      act: (bloc) => bloc.add(FilterUpdated(VisibilityFilter.completed)),
      expect: () => <FilteredTodosState>[
        FilteredTodosLoadSuccess(filteredTodos: todosRandomCompleteOnlyComplete, currentFilter: VisibilityFilter.completed),
      ],
    );
  });
}

const todos = [
  Todo('wash dishes', id: '1234'),
];

const todosRandomComplete = [
  Todo('wash dishes11', id: '11', complete: false),
  Todo('wash dishes12', id: '12', complete: true),
  Todo('wash dishes13', id: '13', complete: false),
  Todo('wash dishes14', id: '14', complete: true),
  Todo('wash dishes15', id: '15', complete: true),
  Todo('wash dishes16', id: '16', complete: false),
];
const todosRandomCompleteOnlyComplete = [
  Todo('wash dishes12', id: '12', complete: true),
  Todo('wash dishes14', id: '14', complete: true),
  Todo('wash dishes15', id: '15', complete: true),
];
const todosRandomCompleteOnlyActive = [
  Todo('wash dishes11', id: '11', complete: false),
  Todo('wash dishes13', id: '13', complete: false),
  Todo('wash dishes16', id: '16', complete: false),
];
