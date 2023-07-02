import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/models/weather_data_daily.dart';
import 'package:weather_app/models/weather_data_hourly.dart';

class WeatherData {
  const WeatherData([this.current, this.hourly, this.daily]);

  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;

  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
  WeatherDataDaily getDailyWeather() => daily!;
}
