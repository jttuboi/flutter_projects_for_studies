// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/todos/todos.dart';

void main() {
  group('TabBloc', () {
    group('TabUpdated', () {
      blocTest<TabBloc, AppTab>(
        'emits AppTab when TabUpdated is added.',
        build: () => TabBloc(),
        act: (bloc) => bloc.add(TabUpdated(AppTab.stats)),
        expect: () => const <AppTab>[AppTab.stats],
      );
    });
  });
}
