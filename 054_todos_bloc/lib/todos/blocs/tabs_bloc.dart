import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_bloc/todos/todos.dart';

part 'tabs_event.dart';
part 'tabs_state.dart';

class TabsBloc extends Bloc<TabsEvent, TabsState> {
  TabsBloc({
    required ITodosRepository todosRepository,
    required StatsBloc statsBloc,
    required TodosBloc todosBloc,
  })  : _todosRepository = todosRepository,
        _statsBloc = statsBloc,
        _todosBloc = todosBloc,
        super(const TabsState()) {
    on<TabChanged>(_onTabChanged);
    on<MarkAllCompleted>(_onMarkAllCompleted);
    on<MarkAllIncompleted>(_onMarkAllIncompleted);
    on<ClearCompleted>(_onClearCompleted);
  }

  final ITodosRepository _todosRepository;
  final StatsBloc _statsBloc;
  final TodosBloc _todosBloc;

  Future<void> _onTabChanged(TabChanged event, Emitter<TabsState> emit) async {
    emit(state.copyWith(
      currentTabIndex: event.tabIndex,
      isTodosTab: event.tabIndex == 0,
      hasIncomplete: await _todosRepository.hasIncomplete(),
    ));
    if (state.currentTabIndex == 0) {
      _todosBloc.add(TodosTabOpened());
    } else {
      _statsBloc.add(StatsTabOpened());
    }
  }

  Future<void> _onMarkAllCompleted(MarkAllCompleted event, Emitter<TabsState> emit) async {
    await _todosRepository.markAllToComplete();
    emit(state.copyWith(
      hasIncomplete: await _todosRepository.hasIncomplete(),
    ));
    if (state.currentTabIndex == 0) {
      _todosBloc.add(TodosTabOpened());
    } else {
      _statsBloc.add(StatsTabOpened());
    }
  }

  Future<void> _onMarkAllIncompleted(MarkAllIncompleted event, Emitter<TabsState> emit) async {
    await _todosRepository.markAllToIncomplete();
    emit(state.copyWith(
      hasIncomplete: await _todosRepository.hasIncomplete(),
    ));
    if (state.currentTabIndex == 0) {
      _todosBloc.add(TodosTabOpened());
    } else {
      _statsBloc.add(StatsTabOpened());
    }
  }

  Future<void> _onClearCompleted(ClearCompleted event, Emitter<TabsState> emit) async {
    await _todosRepository.clearAllCompleted();
    emit(state.copyWith(
      hasIncomplete: await _todosRepository.hasIncomplete(),
    ));
    if (state.currentTabIndex == 0) {
      _todosBloc.add(TodosTabOpened());
    } else {
      _statsBloc.add(StatsTabOpened());
    }
  }
}
