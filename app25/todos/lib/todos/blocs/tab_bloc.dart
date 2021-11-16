import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.todos) {
    on<TabUpdated>(_onTabUpdated);
  }

  Future<void> _onTabUpdated(TabUpdated event, Emitter<AppTab> emit) async {
    if (event is TabUpdated) {
      emit(event.tab);
    }
  }
}
