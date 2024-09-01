import 'package:weather_app/models/models.dart';

class WeatherDataHourly {
  const WeatherDataHourly({required this.hourly});

  final List<Hourly> hourly;

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) => WeatherDataHourly(
        hourly: List<Hourly>.from(json['hourly'].map((e) => Hourly.fromJson(e))),
      );
}
