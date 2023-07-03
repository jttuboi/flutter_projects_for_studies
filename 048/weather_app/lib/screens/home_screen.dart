import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/global_controller.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _globalController = Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => _globalController.checkLoading().isTrue
              ? Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Image.asset('assets/images/icons/clouds.png', height: 200, width: 200),
                    const CircularProgressIndicator(),
                  ]),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(height: 20),
                      const HeaderTile(),
                      CurrentWeatherTile(weatherDataCurrent: _globalController.getWeatherData().getCurrentWeather()),
                      const SizedBox(height: 20),
                      HourlyTile(weatherDataHourly: _globalController.getWeatherData().getHourlyWeather()),
                      DailyForecastTile(weatherDataDaily: _globalController.getWeatherData().getDailyWeather()),
                      Container(height: 1, color: UColors.dividerLine),
                      const SizedBox(height: 10),
                      ComfortLevelTile(weatherDataCurrent: _globalController.getWeatherData().getCurrentWeather()),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
