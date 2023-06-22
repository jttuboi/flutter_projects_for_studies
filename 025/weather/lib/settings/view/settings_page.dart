import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather/weather.dart';

class SettingsPage extends StatelessWidget {
  static Route route(WeatherCubit weatherCubit) {
    return MaterialPageRoute<void>(
      builder: (context) => BlocProvider.value(
        value: weatherCubit,
        child: SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          BlocBuilder<WeatherCubit, WeatherState>(
            buildWhen: (previous, current) {
              return previous.temperatureUnits != current.temperatureUnits;
            },
            builder: (context, state) {
              return ListTile(
                title: const Text('Temperature Units'),
                isThreeLine: true,
                subtitle: const Text('Use metric measurements for temperature units.'),
                trailing: Switch(
                  value: state.temperatureUnits.isCelsius,
                  onChanged: (value) => context.read<WeatherCubit>().toggleUnits(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
