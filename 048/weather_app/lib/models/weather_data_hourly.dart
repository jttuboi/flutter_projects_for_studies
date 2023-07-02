class WeatherDataHourly {
  const WeatherDataHourly({required this.hourly});

  final List<Hourly> hourly;

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) => WeatherDataHourly(
        hourly: List<Hourly>.from(json['hourly'].map((e) => Hourly.fromJson(e))),
      );
}

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

class Weather {
  const Weather({this.id, this.main, this.description, this.icon});

  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'] as int?,
        main: json['main'] as String?,
        description: json['description'] as String?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}
