import 'package:semana_do_flutter_gerencia_estado/redux/store.dart';

enum AppAction {
  increment,
  decrement,
}

extension AppActionExtension on AppAction {
  bool get isIncrement => this == AppAction.increment;
  bool get isDecrement => this == AppAction.decrement;
}

class AppState {
  AppState({this.value = 0});

  final int value;

  operator +(int incrementValue) {
    return AppState(value: (value + incrementValue));
  }

  operator -(int decrementValue) {
    return AppState(value: value - decrementValue);
  }

  @override
  String toString() {
    return '$value';
  }
}

// armazena o store numa variavel global
final appStore = Store<AppAction, AppState>(
  initialState: AppState(),
  reducer: _reducer,
);

AppState _reducer(AppState state, AppAction action) {
  if (action.isIncrement) {
    //return AppState(value: state.value + 1);
    return state + 1;
  } else {
    //return AppState(value: state.value - 1);
    return state - 1;
  }
}
