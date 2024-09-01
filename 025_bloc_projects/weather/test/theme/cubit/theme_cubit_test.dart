import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:weather/theme/cubit/theme_cubit.dart';
import 'package:weather/weather/weather.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../helpers/hydrated_bloc.dart';

class MockWeather extends Mock implements Weather {
  MockWeather(this._condition);

  final WeatherCondition _condition;

  @override
  WeatherCondition get condition => _condition;
}

void main() {
  initHydratedBloc();
  group('ThemeCubit', () {
    test('initial state is correct', () {
      expect(ThemeCubit().state, ThemeCubit.defaultColor);
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        final themeCubit = ThemeCubit();
        expect(themeCubit.fromJson(themeCubit.toJson(themeCubit.state)), themeCubit.state);
      });
    });

    group('updateTheme', () {
      final clearWeather = MockWeather(WeatherCondition.clear);
      final snowyWeather = MockWeather(WeatherCondition.snowy);
      final cloudyWeather = MockWeather(WeatherCondition.cloudy);
      final rainyWeather = MockWeather(WeatherCondition.rainy);
      final unknownWeather = MockWeather(WeatherCondition.unknown);

      blocTest<ThemeCubit, Color>(
        'emits correct color for WeatherCondition.clear',
        build: () => ThemeCubit(),
        act: (cubit) => cubit.updateTheme(clearWeather),
        expect: () => [Colors.orangeAccent],
      );

      blocTest<ThemeCubit, Color>(
        'emits correct color for WeatherCondition.snowy',
        build: () => ThemeCubit(),
        act: (cubit) => cubit.updateTheme(snowyWeather),
        expect: () => [Colors.lightBlueAccent],
      );

      blocTest<ThemeCubit, Color>(
        'emits correct color for WeatherCondition.cloudy',
        build: () => ThemeCubit(),
        act: (cubit) => cubit.updateTheme(cloudyWeather),
        expect: () => [Colors.blueGrey],
      );

      blocTest<ThemeCubit, Color>(
        'emits correct color for WeatherCondition.rainy',
        build: () => ThemeCubit(),
        act: (cubit) => cubit.updateTheme(rainyWeather),
        expect: () => [Colors.indigoAccent],
      );

      blocTest<ThemeCubit, Color>(
        'emits correct color for WeatherCondition.unknown',
        build: () => ThemeCubit(),
        act: (cubit) => cubit.updateTheme(unknownWeather),
        expect: () => [ThemeCubit.defaultColor],
      );
    });
  });
}
