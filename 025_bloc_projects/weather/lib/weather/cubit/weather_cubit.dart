import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/weather/models/models.dart';
import 'package:weather_repository/weather_repository.dart' show WeatherRepository;

part 'weather_cubit.g.dart';
part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(WeatherState());

  final WeatherRepository _weatherRepository;

  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) {
      return;
    }

    // inicia com estado de loading
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = Weather.fromRepository(await _weatherRepository.getWeather(city));
      final units = state.temperatureUnits;
      // o valor a ser mostrado já é convertido antes de enviar, pois o estado só muda com uma ação
      // e não há necessidade de converter o valor depois
      final value = units.isFahrenheit ? weather.temperature.value.toFahrenheit() : weather.temperature.value;

      // ao conseguir pegar os dados do weather, envia o estado de sucess
      emit(state.copyWith(
        status: WeatherStatus.success,
        temperatureUnits: units,
        weather: weather.copyWith(temperature: Temperature(value: value)),
      ));
    } on Exception {
      // se houve qualquer erro na busca ou envio de sucesso, ele manda como failure
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> refreshWeather() async {
    // só permite atualizar se anteriormente foi sucesso
    // só permite atualizar se anteriormente teve algum weather
    if (state.status.isNotSuccess || state.weather == Weather.empty) {
      return;
    }

    try {
      final weather = Weather.fromRepository(await _weatherRepository.getWeather(state.weather.location));
      final units = state.temperatureUnits;
      final value = units.isFahrenheit ? weather.temperature.value.toFahrenheit() : weather.temperature.value;

      // emite o weather atualizado
      emit(state.copyWith(
        status: WeatherStatus.success,
        temperatureUnits: units,
        weather: weather.copyWith(temperature: Temperature(value: value)),
      ));
    } on Exception {
      // caso ocorra qualquer erro nesse meio tempo, envia o mesmo estado anterior
      emit(state);
    }
  }

  void toggleUnits() {
    final units = state.temperatureUnits.isFahrenheit ? TemperatureUnits.celsius : TemperatureUnits.fahrenheit;

    // caso o estado anterior não for sucesso, retorna o anterior, porém com a nova unidade
    // TODO pq não reatualiza o valor da temperatura?
    if (state.status.isNotSuccess) {
      emit(state.copyWith(temperatureUnits: units));
      return;
    }

    final weather = state.weather;
    if (weather != Weather.empty) {
      // se existe algum weather do estado anterior, converte o weather para nova unidade de temperatura
      final temperature = weather.temperature;
      final value = units.isCelsius ? temperature.value.toCelsius() : temperature.value.toFahrenheit();
      emit(state.copyWith(
        temperatureUnits: units,
        weather: weather.copyWith(temperature: Temperature(value: value)),
      ));
    }
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    return WeatherState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    return state.toJson();
  }
}
