import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos/todos/blocs/blocs.dart';
import 'package:todos/todos/models/models.dart';

part 'stats_event.dart';
part 'stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc({required this.todosBloc}) : super(StatsLoadInProgress()) {
    on<StatsUpdated>(_onStatsUpdated);

    // Diferente do FilteredTodosBloc, esse listener criado já é chamado logo que é criado (o ojbeto bloc).
    // Mas ele faz a mesma coisa que do outro, quando o stream do todoBloc é atualizado, esse listener é chamado.
    // Ao ser chamado, ele irá atualizar os dados dos stats.
    void onTodosStateChanged(state) {
      if (state is TodosLoadSuccess) {
        add(StatsUpdated(state.todos));
      }
    }

    onTodosStateChanged(todosBloc.state);
    todosSubscription = todosBloc.stream.listen(onTodosStateChanged);
  }

  final TodosBloc todosBloc;
  late final StreamSubscription todosSubscription;

  Future<void> _onStatsUpdated(StatsUpdated event, Emitter<StatsState> emit) async {
    final numActive = event.todos.where((todo) => !todo.complete).toList().length;
    final numCompleted = event.todos.where((todo) => todo.complete).toList().length;
    emit(StatsLoadSuccess(numActive, numCompleted));
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}
