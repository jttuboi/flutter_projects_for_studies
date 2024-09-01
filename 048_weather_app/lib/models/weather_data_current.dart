import 'package:weather_app/models/models.dart';

class WeatherDataCurrent {
  const WeatherDataCurrent({required this.current});

  final Current current;

  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) => WeatherDataCurrent(
        current: Current.fromJson(json['current']),
      );
}
