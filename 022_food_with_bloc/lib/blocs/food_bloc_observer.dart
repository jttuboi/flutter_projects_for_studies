// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';

class FoodBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    print('${bloc.runtimeType}::onCreate');
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    print('${bloc.runtimeType}::onClose');
    super.onClose(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print('${bloc.runtimeType}::onChange: $change');
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('${bloc.runtimeType}::onTransition: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print('${bloc.runtimeType}::onEvent: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType}::onError: $error');
    print(stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
