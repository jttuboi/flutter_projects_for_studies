class WeatherDataCurrent {
  const WeatherDataCurrent({required this.current});

  final Current current;

  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) => WeatherDataCurrent(
        current: Current.fromJson(json['current']),
      );
}

class Current {
  const Current({
    this.temp,
    this.humidity,
    this.feelsLike,
    this.clouds,
    this.uvIndex,
    this.windSpeed,
    this.weather,
  });

  final int? temp;
  final int? humidity;
  final int? clouds;
  final double? uvIndex;
  final double? feelsLike;
  final double? windSpeed;
  final List<Weather>? weather;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        temp: (json['temp'] as num?)?.round(),
        feelsLike: (json['feels_like'] as num?)?.toDouble(),
        humidity: json['humidity'] as int?,
        uvIndex: (json['uvi'] as num?)?.toDouble(),
        clouds: json['clouds'] as int?,
        windSpeed: (json['wind_speed'] as num?)?.toDouble(),
        weather: (json['weather'] as List<dynamic>?)?.map((e) => Weather.fromJson(e as Map<String, dynamic>)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'uvi': uvIndex,
        'humidity': humidity,
        'clouds': clouds,
        'wind_speed': windSpeed,
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
