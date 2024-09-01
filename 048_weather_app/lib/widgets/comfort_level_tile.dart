import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/utils/utils.dart';

class ComfortLevelTile extends StatelessWidget {
  const ComfortLevelTile({required this.weatherDataCurrent, super.key});

  final WeatherDataCurrent weatherDataCurrent;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 20),
        child: const Text('Comfort Level', style: TextStyle(fontSize: 18)),
      ),
      SizedBox(
        height: 180,
        child: Column(children: [
          Center(
            child: SleekCircularSlider(
              min: 0,
              max: 100,
              initialValue: weatherDataCurrent.current.humidity!.toDouble(),
              appearance: CircularSliderAppearance(
                infoProperties: InfoProperties(
                  bottomLabelText: 'Humidity',
                  bottomLabelStyle: const TextStyle(letterSpacing: 0.1, fontSize: 14, height: 1.5),
                ),
                customWidths: CustomSliderWidths(handlerSize: 0, trackWidth: 12, progressBarWidth: 12),
                animationEnabled: true,
                size: 140,
                customColors: CustomSliderColors(
                  hideShadow: true,
                  trackColor: UColors.firstGradientColor.withAlpha(100),
                  progressBarColors: [
                    UColors.firstGradientColor,
                    UColors.secondGradientColor,
                  ],
                ),
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            RichText(
              text: TextSpan(children: [
                const TextSpan(
                  text: 'Feels Like ',
                  style: TextStyle(fontSize: 14, height: 0.8, color: UColors.textColorBlack, fontWeight: FontWeight.w400),
                ),
                TextSpan(
                  text: '${weatherDataCurrent.current.feelsLike}',
                  style: const TextStyle(fontSize: 14, height: 0.8, color: UColors.textColorBlack, fontWeight: FontWeight.w400),
                ),
              ]),
            ),
            Container(
              height: 25,
              width: 1,
              margin: const EdgeInsets.only(left: 40, right: 40),
              color: UColors.dividerLine,
            ),
            RichText(
              text: TextSpan(children: [
                const TextSpan(
                  text: 'UV Index ',
                  style: TextStyle(fontSize: 14, height: 0.8, color: UColors.textColorBlack, fontWeight: FontWeight.w400),
                ),
                TextSpan(
                  text: '${weatherDataCurrent.current.uvIndex}',
                  style: const TextStyle(fontSize: 14, height: 0.8, color: UColors.textColorBlack, fontWeight: FontWeight.w400),
                ),
              ]),
            ),
          ]),
        ]),
      ),
    ]);
  }
}
