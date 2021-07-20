import 'package:bloc/bloc.dart';

enum AppEvent {
  increment,
  decrement,
}

extension AppEventExtension on AppEvent {
  bool get isIncrement => this == AppEvent.increment;
  bool get isDecrement => this == AppEvent.decrement;
}

class AppBloc extends Bloc<AppEvent, int> {
  // o estado é representado por um inteiro nesse teste
  // para o construtor, precisa passar o valor inicial, nesse caso é 0
  // AppBloc(int initialState) : super(initialState);
  AppBloc() : super(0);

  // aqui, por utilizar a Stream é possivel ter quantos retornos você quiser ver ex abaixo
  @override
  Stream<int> mapEventToState(AppEvent event) async* {
    if (event.isIncrement) {
      yield state + 1;
    } else {
      yield state - 1;
    }
  }
}

final appBloc = AppBloc();

// async* mostra que terá vários retornos
// o yield é o return, mas como pode ter vários retornos ao mesmo tempo, no sentido que todos
// irão ser chamados, então tem essa mudança de nomenclatura

// @override
// Stream<int> mapEventToState(AppEvent event) async* {
//   yield state + 1;
//   yield state + 1;
//   yield state + 1;
//   yield state + 1;
// }
