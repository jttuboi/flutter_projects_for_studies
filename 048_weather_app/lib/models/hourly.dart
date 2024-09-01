import 'package:weather_app/models/models.dart';

class Hourly {
  const Hourly({
    this.dt,
    this.temp,
    this.weather,
  });

  final int? dt;
  final int? temp;
  final List<Weather>? weather;

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json['dt'] as int?,
        temp: (json['temp'] as num?)?.round(),
        weather: (json['weather'] as List<dynamic>?)?.map((e) => Weather.fromJson(e as Map<String, dynamic>)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
        'weather': weather?.map((e) => e.toJson()).toList(),
      };
}
