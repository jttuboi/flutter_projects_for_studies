// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_redundant_argument_values

import 'dart:developer';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/todos/todos.dart';

import '../../mocks.dart';
import '../../support.dart';

void main() {
  group('TodosBloc', () {
    late ITodosRepository todosRepository;
    late IUuidGenerator uuidGenerator;
    late TodosBloc todosBloc;

    setUp(() {
      todosRepository = MockTodosRepository();
      uuidGenerator = MockUuidGenerator();
      todosBloc = TodosBloc(todosRepository: todosRepository, uuidGenerator: uuidGenerator);
    });

    blocTest<TodosBloc, TodosState>(
      'emits TodosLoadSuccess when TodosLoaded is added',
      build: () {
        when(() => todosRepository.loadTodos()).thenAnswer((_) => <TodoEntity>[].cloneAsync());
        return todosBloc;
      },
      act: (bloc) => bloc.add(TodosLoaded()),
      expect: () {
        verify(() => todosRepository.loadTodos()).called(1);
        return <TodosState>[
          TodosLoadSuccess(),
        ];
      },
    );

    blocTest<TodosBloc, TodosState>(
      'emits TodosLoadSuccess with todos when loadTodos return todos',
      build: () {
        when(() => todosRepository.loadTodos()).thenAnswer((_) => [TodoEntity('10', 'wash dishes', 'with soap', false)].cloneAsync());
        return todosBloc;
      },
      act: (bloc) => bloc.add(TodosLoaded()),
      expect: () {
        verify(() => todosRepository.loadTodos()).called(1);
        return <TodosState>[
          TodosLoadSuccess([Todo('wash dishes', id: '10', note: 'with soap', complete: false)]),
        ];
      },
    );

    blocTest<TodosBloc, TodosState>(
      'emits TodosLoadFailure when respository throws any exception',
      build: () {
        when(() => todosRepository.loadTodos()).thenThrow(Exception('any database error'));
        return todosBloc;
      },
      act: (bloc) => bloc.add(TodosLoaded()),
      expect: () {
        verify(() => todosRepository.loadTodos()).called(1);
        return <TodosState>[
          TodosLoadFailure(),
        ];
      },
    );

    blocTest<TodosBloc, TodosState>(
      'emits TodosLoadSuccess when TodoAdded is added with Todo',
      build: () {
        when(() => todosRepository.loadTodos()).thenAnswer((_) => todoEntities.cloneAsync());
        when(() => todosRepository.saveTodos(any())).thenAnswer((_) => Future.value());
        return todosBloc..add(TodosLoaded());
      },
      skip: 1,
      act: (bloc) => bloc.add(TodoAdded(Todo('task', id: '123', note: 'note', complete: true))),
      expect: () {
        verify(() => todosRepository.saveTodos(any())).called(1);
        return <TodosState>[
          TodosLoadSuccess(todos.clone()..add(Todo('task', id: '123', note: 'note', complete: true))),
        ];
      },
    );

    blocTest<TodosBloc, TodosState>(
      'emits TodosLoadSuccess when TodoAdded is added with Todo without id',
      build: () {
        when(() => todosRepository.loadTodos()).thenAnswer((_) => todoEntities.cloneAsync());
        when(() => uuidGenerator.getV4()).thenReturn('meu uuid v4');
        when(() => todosRepository.saveTodos(any())).thenAnswer((_) => Future.value());
        return todosBloc..add(TodosLoaded());
      },
      skip: 1,
      act: (bloc) => bloc.add(TodoAdded(Todo('task', id: '', note: 'note', complete: true))),
      expect: () {
        verify(() => todosRepository.saveTodos(any())).called(1);
        return <TodosState>[
          TodosLoadSuccess(todos.clone()..add(Todo('task', id: 'meu uuid v4', note: 'note', complete: true))),
        ];
      },
    );

    blocTest<TodosBloc, TodosState>(
      'emits TodosLoadSuccess when TodoUpdated is added with Todo modified',
      build: () {
        when(() => todosRepository.loadTodos()).thenAnswer((_) {
          final cloneAsync = todoEntities.cloneAsync(addAll: [TodoEntity('123', 'task to edit', 'need edit this', true)]);
          inspect(cloneAsync);
          return cloneAsync;
        });
        when(() => todosRepository.saveTodos(any())).thenAnswer((_) => Future.value());
        return todosBloc..add(TodosLoaded());
      },
      skip: 1,
      act: (bloc) => bloc.add(TodoUpdated(Todo('task to edit', id: '123', note: 'this note is edited', complete: true))),
      expect: () {
        verify(() => todosRepository.saveTodos(any())).called(1);
        return <TodosState>[
          TodosLoadSuccess(todos.clone()..add(Todo('task to edit', id: '123', note: 'this note is edited', complete: true))),
        ];
      },
    );

    blocTest<TodosBloc, TodosState>(
      'emits TodosLoadSuccess when TodoUpdated is added with Todo modified (complete changes)',
      build: () {
        when(() => todosRepository.loadTodos()).thenAnswer((_) {
          return todoEntities.cloneAsync(addAll: [TodoEntity('123', 'task to edit', 'note', true)]);
        });
        when(() => todosRepository.saveTodos(any())).thenAnswer((_) => Future.value());
        return todosBloc..add(TodosLoaded());
      },
      skip: 1,
      act: (bloc) => bloc.add(TodoUpdated(Todo('task to edit', id: '123', note: 'note', complete: false))),
      expect: () {
        verify(() => todosRepository.saveTodos(any())).called(1);
        return <TodosState>[
          TodosLoadSuccess(todos.clone()..add(Todo('task to edit', id: '123', note: 'note', complete: false))),
        ];
      },
    );

    blocTest<TodosBloc, TodosState>(
      'emits TodosLoadSuccess when TodoDeleted is added with Todo to delete',
      build: () {
        when(() => todosRepository.loadTodos()).thenAnswer((_) {
          return todoEntities.cloneAsync(addAll: [TodoEntity('123', 'task to delete', 'note', true)]);
        });
        when(() => todosRepository.saveTodos(any())).thenAnswer((_) => Future.value());
        return todosBloc..add(TodosLoaded());
      },
      skip: 1,
      act: (bloc) => bloc.add(TodoDeleted(Todo('task to delete', id: '123', note: 'note', complete: true))),
      expect: () {
        verify(() => todosRepository.saveTodos(any())).called(1);
        return <TodosState>[
          TodosLoadSuccess(todos.clone()),
        ];
      },
    );

    blocTest<TodosBloc, TodosState>(
      'emits TodosLoadSuccess when ToggleAll is added with all Todo completed',
      build: () {
        when(() => todosRepository.loadTodos()).thenAnswer((_) => todoEntitiesRandomComplete.cloneAsync());
        when(() => todosRepository.saveTodos(any())).thenAnswer((_) => Future.value());
        return todosBloc..add(TodosLoaded());
      },
      skip: 1,
      act: (bloc) => bloc.add(ToggleAll()),
      expect: () {
        verify(() => todosRepository.saveTodos(any())).called(1);
        return <TodosState>[
          TodosLoadSuccess(todosRandomCompleteAllTrue.clone()),
        ];
      },
    );

    blocTest<TodosBloc, TodosState>(
      'emits TodosLoadSuccess when ToggleAll is added with all Todo incomplete (active)',
      build: () {
        when(() => todosRepository.loadTodos()).thenAnswer((_) => todoEntitiesRandomCompleteAllTrue.cloneAsync());
        when(() => todosRepository.saveTodos(any())).thenAnswer((_) => Future.value());
        return todosBloc..add(TodosLoaded());
      },
      skip: 1,
      act: (bloc) => bloc.add(ToggleAll()),
      expect: () {
        verify(() => todosRepository.saveTodos(any())).called(1);
        return <TodosState>[
          TodosLoadSuccess(todosRandomCompleteAllFalse.clone()),
        ];
      },
    );

    blocTest<TodosBloc, TodosState>(
      'emits TodosLoadSuccess when ClearCompleted is added',
      build: () {
        when(() => todosRepository.loadTodos()).thenAnswer((_) => todoEntitiesRandomComplete.cloneAsync());
        when(() => todosRepository.saveTodos(any())).thenAnswer((_) => Future.value());
        return todosBloc..add(TodosLoaded());
      },
      skip: 1,
      act: (bloc) => bloc.add(ClearCompleted()),
      expect: () {
        verify(() => todosRepository.saveTodos(any())).called(1);
        return <TodosState>[
          TodosLoadSuccess(todosRandomCompleteOnlyFalse.clone()),
        ];
      },
    );
  });
}

const todoEntities = <TodoEntity>[TodoEntity('10', 'cook bake', 'ingredients: blablabla', false)];
const todos = <Todo>[Todo('cook bake', id: '10', note: 'ingredients: blablabla', complete: false)];

const todoEntitiesRandomComplete = <TodoEntity>[
  TodoEntity('10', 'cook bake0', 'ingredients: blablabla', false),
  TodoEntity('11', 'cook bake1', 'ingredients: blablabla', true),
  TodoEntity('12', 'cook bake2', 'ingredients: blablabla', false),
  TodoEntity('13', 'cook bake3', 'ingredients: blablabla', true),
];
const todosRandomCompleteAllTrue = <Todo>[
  Todo('cook bake0', id: '10', note: 'ingredients: blablabla', complete: true),
  Todo('cook bake1', id: '11', note: 'ingredients: blablabla', complete: true),
  Todo('cook bake2', id: '12', note: 'ingredients: blablabla', complete: true),
  Todo('cook bake3', id: '13', note: 'ingredients: blablabla', complete: true),
];
const todosRandomCompleteOnlyFalse = <Todo>[
  Todo('cook bake0', id: '10', note: 'ingredients: blablabla', complete: false),
  Todo('cook bake2', id: '12', note: 'ingredients: blablabla', complete: false),
];

const todoEntitiesRandomCompleteAllTrue = <TodoEntity>[
  TodoEntity('10', 'cook bake0', 'ingredients: blablabla', true),
  TodoEntity('11', 'cook bake1', 'ingredients: blablabla', true),
  TodoEntity('12', 'cook bake2', 'ingredients: blablabla', true),
  TodoEntity('13', 'cook bake3', 'ingredients: blablabla', true),
];
const todosRandomCompleteAllFalse = <Todo>[
  Todo('cook bake0', id: '10', note: 'ingredients: blablabla', complete: false),
  Todo('cook bake1', id: '11', note: 'ingredients: blablabla', complete: false),
  Todo('cook bake2', id: '12', note: 'ingredients: blablabla', complete: false),
  Todo('cook bake3', id: '13', note: 'ingredients: blablabla', complete: false),
];
