// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/todos/todos.dart';

import '../../mocks.dart';

void main() {
  late TodosBloc todosBloc;

  setUp(() {
    todosBloc = MockTodosBloc();
  });

  setUpAll(() {
    registerFallbackValue(TodosLoadSuccess());
    registerFallbackValue(TodosLoaded());
  });

  group('StatsBloc', () {
    blocTest<StatsBloc, StatsState>(
      'emits StatsLoadSuccess when StatsUpdated is added',
      build: () {
        whenListen(todosBloc, Stream<TodosState>.fromIterable([]), initialState: TodosLoadSuccess(const []));
        return StatsBloc(todosBloc: todosBloc);
      },
      act: (bloc) => bloc.add(StatsUpdated(any())),
      expect: () => const <StatsState>[
        StatsLoadSuccess(0, 0),
      ],
    );

    blocTest<StatsBloc, StatsState>(
      'emits StatsLoadSuccess when StatsUpdated is added with TodoList 2 complete and 4 actives',
      build: () {
        whenListen(todosBloc, Stream<TodosState>.fromIterable([]), initialState: TodosLoadSuccess(todoEntitiesWith2Complete4Active));
        return StatsBloc(todosBloc: todosBloc);
      },
      act: (bloc) => bloc.add(StatsUpdated(any())),
      expect: () => const <StatsState>[
        StatsLoadSuccess(4, 2),
      ],
    );

    blocTest<StatsBloc, StatsState>(
      'emits StatsLoadSuccess when StatsUpdated is added with TodoList 4 complete and 2 actives',
      build: () {
        whenListen(todosBloc, Stream<TodosState>.fromIterable([]), initialState: TodosLoadSuccess(todoEntitiesWith4Complete2Active));
        return StatsBloc(todosBloc: todosBloc);
      },
      act: (bloc) => bloc.add(StatsUpdated(any())),
      expect: () => const <StatsState>[
        StatsLoadSuccess(2, 4),
      ],
    );
  });
}

const todoEntitiesWith2Complete4Active = [
  Todo('cook dinner', id: '10', note: 'note', complete: true),
  Todo('cook dinner', id: '11', note: 'note', complete: true),
  Todo('cook dinner', id: '12', note: 'note', complete: false),
  Todo('cook dinner', id: '13', note: 'note', complete: false),
  Todo('cook dinner', id: '14', note: 'note', complete: false),
  Todo('cook dinner', id: '15', note: 'note', complete: false),
];

const todoEntitiesWith4Complete2Active = [
  Todo('cook dinner', id: '20', note: 'note', complete: false),
  Todo('cook dinner', id: '21', note: 'note', complete: false),
  Todo('cook dinner', id: '22', note: 'note', complete: true),
  Todo('cook dinner', id: '23', note: 'note', complete: true),
  Todo('cook dinner', id: '24', note: 'note', complete: true),
  Todo('cook dinner', id: '25', note: 'note', complete: true),
];
