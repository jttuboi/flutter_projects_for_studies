import 'package:flutter/material.dart';
import 'package:semana_do_flutter_testes_unitarios/person_bloc.dart';

class BlocProvider extends InheritedWidget {
  BlocProvider({required this.bloc, required Widget child})
      : super(child: child);

  final PersonBloc bloc;

  static PersonBloc get(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<BlocProvider>();
    if (provider != null) {
      return provider.bloc;
    } else {
      throw Exception('Not found bloc');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return (oldWidget as BlocProvider).bloc.state != bloc.state;
  }
}
