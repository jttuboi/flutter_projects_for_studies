// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_with_stream/bloc/ticker_bloc.dart';
import 'package:bloc_with_stream/models/ticker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTicker extends Mock implements Ticker {}

void main() {
  group('TickerBloc', () {
    late Ticker ticker;

    setUp(() {
      ticker = MockTicker();
      // mocka o tick() para gerar um stream que emite valores 1, 2 e 3 (sem aquele que o sistema utiliza com duration)
      when(ticker.tick).thenAnswer((invocation) => Stream<int>.fromIterable([1, 2, 3]));
    });

    test('initial state is TickerInitial', () {
      expect(TickerBloc(ticker).state, TickerInitial());
    });

    // cria um test diretamente para o bloc
    blocTest<TickerBloc, TickerState>(
      'emits [] when ticker has not started',
      build: () => TickerBloc(ticker),
      expect: () => [],
    );

    blocTest<TickerBloc, TickerState>(
      'emits TickerTickSuccess from 1 to 3',
      build: () => TickerBloc(ticker),
      act: (bloc) => bloc.add(TickerStarted()),
      expect: () => [
        TickerTickSuccess(1),
        TickerTickSuccess(2),
        TickerTickSuccess(3),
        TickerComplete(),
      ],
    );

    blocTest<TickerBloc, TickerState>(
      'emits TickerTickSuccess from 1 to 3 and cancels previous subscription',
      build: () => TickerBloc(ticker),
      act: (bloc) => bloc
        ..add(TickerStarted())
        ..add(TickerStarted()),
      expect: () => [
        TickerTickSuccess(1),
        TickerTickSuccess(2),
        TickerTickSuccess(3),
        TickerComplete(),
      ],
    );
  });
}
