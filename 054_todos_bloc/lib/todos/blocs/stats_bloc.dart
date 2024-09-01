import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_bloc/todos/todos.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc({required ITodosRepository todosRepository})
      : _todosRepository = todosRepository,
        super(const StatsState()) {
    on<StatsTabOpened>(_onStatsTabOpened);
    on<StatsTodosUpdated>(_onTodosUpdated);
  }

  final ITodosRepository _todosRepository;

  Future<void> _onStatsTabOpened(StatsTabOpened event, Emitter<StatsState> emit) async {
    final mapCounter = await _todosRepository.countTodosSituation();
    emit(state.copyWith(
      activeTodosQuantity: mapCounter[ITodosRepository.incompleteSituation].toString(),
      completedTodosQuantity: mapCounter[ITodosRepository.completeSituation].toString(),
    ));
  }

  Future<void> _onTodosUpdated(StatsTodosUpdated event, Emitter<StatsState> emit) async {
    final mapCounter = await _todosRepository.countTodosSituation();
    emit(state.copyWith(
      activeTodosQuantity: mapCounter[ITodosRepository.incompleteSituation].toString(),
      completedTodosQuantity: mapCounter[ITodosRepository.completeSituation].toString(),
    ));
  }
}
