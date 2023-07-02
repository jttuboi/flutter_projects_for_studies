import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/services/api_key.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  Future<WeatherData> processData(double latitude, double longitude) async {
    final response = await http.get(Uri.parse(apiUrl(latitude, longitude)));
    final jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
      WeatherDataCurrent.fromJson(jsonString),
    );

    return weatherData!;
  }
}

String apiUrl(double latitude, double longitude) {
  return 'https://api.openweathermap.org/data/3.0/onecall?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&exclude=minutely';
}
