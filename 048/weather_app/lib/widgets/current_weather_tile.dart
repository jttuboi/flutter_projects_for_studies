import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/utils/utils.dart';

class CurrentWeatherTile extends StatelessWidget {
  const CurrentWeatherTile({required this.weatherDataCurrent, super.key});

  final WeatherDataCurrent weatherDataCurrent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _temperatureArea(),
        const SizedBox(height: 20),
        _currentWeatherMoreDetails(),
      ],
    );
  }

  Widget _temperatureArea() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Image.asset('assets/images/weather/${weatherDataCurrent.current.weather![0].icon}.png', height: 80, width: 80),
      Container(height: 50, width: 1, color: UColors.dividerLine),
      RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '${weatherDataCurrent.current.temp!.toInt()}˚',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 68, color: UColors.textColorBlack),
          ),
          TextSpan(
            text: '${weatherDataCurrent.current.weather![0].description}',
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),
          ),
        ]),
      ),
    ]);
  }

  Widget _currentWeatherMoreDetails() {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: UColors.cardColor, borderRadius: BorderRadius.circular(15)),
          child: Image.asset('assets/images/icons/windspeed.png'),
        ),
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: UColors.cardColor, borderRadius: BorderRadius.circular(15)),
          child: Image.asset('assets/images/icons/clouds.png'),
        ),
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: UColors.cardColor, borderRadius: BorderRadius.circular(15)),
          child: Image.asset('assets/images/icons/humidity.png'),
        ),
      ]),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        SizedBox(
          height: 20,
          width: 60,
          child: Text('${weatherDataCurrent.current.windSpeed}km/h', style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
        ),
        SizedBox(
          height: 20,
          width: 60,
          child: Text('${weatherDataCurrent.current.clouds}%', style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
        ),
        SizedBox(
          height: 20,
          width: 60,
          child: Text('${weatherDataCurrent.current.humidity}%', style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
        ),
      ]),
    ]);
  }
}
