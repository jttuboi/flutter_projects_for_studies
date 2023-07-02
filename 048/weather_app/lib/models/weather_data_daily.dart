class WeatherDataDaily {
  const WeatherDataDaily({required this.daily});

  final List<Daily> daily;

  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) => WeatherDataDaily(
        daily: List<Daily>.from(json['daily'].map((e) => Daily.fromJson(e))),
      );
}

class Daily {
  const Daily({
    this.dt,
    this.temp,
    this.weather,
  });

  final int? dt;
  final Temp? temp;
  final List<Weather>? weather;

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json['dt'] as int?,
        temp: json['temp'] == null ? null : Temp.fromJson(json['temp'] as Map<String, dynamic>),
        weather: (json['weather'] as List<dynamic>?)?.map((e) => Weather.fromJson(e as Map<String, dynamic>)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp?.toJson(),
        'weather': weather?.map((e) => e.toJson()).toList(),
      };
}

class Temp {
  const Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  final double? day;
  final int? min;
  final int? max;
  final double? night;
  final double? eve;
  final double? morn;

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: (json['day'] as num?)?.toDouble(),
        min: (json['min'] as num?)?.round(),
        max: (json['max'] as num?)?.round(),
        night: (json['night'] as num?)?.toDouble(),
        eve: (json['eve'] as num?)?.toDouble(),
        morn: (json['morn'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'day': day,
        'min': min,
        'max': max,
        'night': night,
        'eve': eve,
        'morn': morn,
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
