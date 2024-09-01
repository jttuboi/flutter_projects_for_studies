import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/todos/todos.dart';

class MockTodosBloc extends MockBloc<TodosEvent, TodosState> implements TodosBloc {}

class MockStatsBloc extends MockBloc<StatsEvent, StatsState> implements StatsBloc {}

class MockTabBloc extends MockBloc<TabEvent, AppTab> implements TabBloc {}

class MockFilteredTodosBloc extends MockBloc<FilteredTodosEvent, FilteredTodosState> implements FilteredTodosBloc {}

class MockTodosRepository extends Mock implements ITodosRepository {}

class MockUuidGenerator extends Mock implements IUuidGenerator {}
