import 'package:flutter/material.dart' hide Action, State;

class Store<Action, State> extends ChangeNotifier {
  Store({required State initialState, required this.reducer}) {
    // aqui é a unica vez em que o estado é inicializado, sempre quando cria o store
    _state = initialState;
  }

  final State Function(State state, Action action) reducer;
  late State _state;

  // única forma de acessar diretamente o estado. Só é possível ler
  State get state => _state;

  void dispatcher(Action action) {
    // atualiza para o novo estado vindo da ação implementada através do reducer
    _state = reducer(state, action);
    notifyListeners();
  }
}
