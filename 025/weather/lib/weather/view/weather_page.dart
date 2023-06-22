import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/search/search.dart';
import 'package:weather/settings/settings.dart';
import 'package:weather/theme/cubit/theme_cubit.dart';
import 'package:weather/weather/cubit/weather_cubit.dart';
import 'package:weather/weather/view/view.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherCubit>(
      create: (context) => WeatherCubit(weatherRepository: context.read<WeatherRepository>()),
      child: WeatherView(),
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(context, SettingsPage.route(context.read<WeatherCubit>())),
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.read<ThemeCubit>().updateTheme(state.weather);
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case WeatherStatus.initial:
                return const WeatherEmpty();
              case WeatherStatus.loading:
                return const WeatherLoading();
              case WeatherStatus.success:
                return WeatherPopulated(
                  weather: state.weather,
                  units: state.temperatureUnits,
                  onRefresh: () => context.read<WeatherCubit>().refreshWeather(),
                );
              case WeatherStatus.failure:
              default:
                return const WeatherError();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final city = await Navigator.push(context, SearchPage.route());
          await context.read<WeatherCubit>().fetchWeather(city);
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
