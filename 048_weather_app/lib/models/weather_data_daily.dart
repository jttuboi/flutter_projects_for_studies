import 'package:weather_app/models/models.dart';

class WeatherDataDaily {
  const WeatherDataDaily({required this.daily});

  final List<Daily> daily;

  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) => WeatherDataDaily(
        daily: List<Daily>.from(json['daily'].map((e) => Daily.fromJson(e))),
      );
}
