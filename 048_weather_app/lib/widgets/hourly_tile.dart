import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/global_controller.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/utils/utils.dart';

class HourlyTile extends StatelessWidget {
  HourlyTile({required this.weatherDataHourly, super.key});

  final WeatherDataHourly weatherDataHourly;
  final RxInt _cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        alignment: Alignment.topCenter,
        child: const Text('Today', style: TextStyle(fontSize: 18)),
      ),
      _hourlyList(),
    ]);
  }

  Widget _hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Obx((() => GestureDetector(
                onTap: () {
                  _cardIndex.value = index;
                },
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(left: 20, right: 5),
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(offset: const Offset(0.5, 0), blurRadius: 30, spreadRadius: 1, color: UColors.dividerLine.withAlpha(150))],
                    gradient:
                        (_cardIndex.value == index) ? const LinearGradient(colors: [UColors.firstGradientColor, UColors.secondGradientColor]) : null,
                  ),
                  child: HourlyCard(
                    temp: weatherDataHourly.hourly[index].temp!,
                    timeStamp: weatherDataHourly.hourly[index].dt!,
                    weatherIcon: weatherDataHourly.hourly[index].weather![0].icon!,
                    index: index,
                    cardIndex: _cardIndex.toInt(),
                  ),
                ),
              )));
        },
        itemCount: weatherDataHourly.hourly.length > 12 ? 14 : weatherDataHourly.hourly.length,
      ),
    );
  }
}

class HourlyCard extends StatelessWidget {
  const HourlyCard({required this.temp, required this.timeStamp, required this.weatherIcon, required this.index, required this.cardIndex, super.key});

  final int temp;
  final int timeStamp;
  final String weatherIcon;
  final int index;
  final int cardIndex;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Container(
        margin: const EdgeInsets.only(top: 10),
        child: Text(_getTime(timeStamp), style: TextStyle(color: (cardIndex == index) ? Colors.white : UColors.textColorBlack)),
      ),
      Container(
        margin: const EdgeInsets.all(5),
        child: Image.asset('assets/images/weather/$weatherIcon.png', height: 40, width: 40),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Text('$temp˚', style: TextStyle(color: (cardIndex == index) ? Colors.white : UColors.textColorBlack)),
      ),
    ]);
  }

  String _getTime(final timeStamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('jm').format(dateTime);
  }
}
