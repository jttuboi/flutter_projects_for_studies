import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_data_daily.dart';
import 'package:weather_app/utils/utils.dart';

class DailyForecastTile extends StatelessWidget {
  const DailyForecastTile({required this.weatherDataDaily, super.key});

  final WeatherDataDaily weatherDataDaily;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: UColors.dividerLine.withAlpha(150), borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(bottom: 10),
          child: const Text('Next Days', style: TextStyle(color: UColors.textColorBlack, fontSize: 17)),
        ),
        _dailyList(),
      ]),
    );
  }

  Widget _dailyList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(children: [
            Container(
              height: 60,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(children: [
                SizedBox(
                    width: 80,
                    child: Text(
                      _getDay(weatherDataDaily.daily[index].dt),
                      style: const TextStyle(color: UColors.textColorBlack, fontSize: 13),
                    )),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset('assets/images/weather/${weatherDataDaily.daily[index].weather![0].icon}.png'),
                ),
                Text('${weatherDataDaily.daily[index].temp!.max}˚/${weatherDataDaily.daily[index].temp!.min}')
              ]),
            ),
            Container(height: 1, color: UColors.dividerLine),
          ]);
        },
        itemCount: weatherDataDaily.daily.length > 7 ? 7 : weatherDataDaily.daily.length,
      ),
    );
  }

  String _getDay(final day) {
    final time = DateTime.fromMillisecondsSinceEpoch(day);
    return DateFormat('EEE').format(time);
  }
}
