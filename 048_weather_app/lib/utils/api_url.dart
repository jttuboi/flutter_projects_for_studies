import 'package:weather_app/utils/utils.dart';

String apiUrl(double latitude, double longitude) {
  return 'https://api.openweathermap.org/data/3.0/onecall?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&exclude=minutely';
}
