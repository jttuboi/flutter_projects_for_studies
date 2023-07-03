import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/global_controller.dart';
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
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(height: 20),
                      const HeaderTile(),
                      CurrentWeatherTile(weatherDataCurrent: _globalController.getWeatherData().getCurrentWeather()),
                      const SizedBox(height: 20),
                      HourlyTile(weatherDataHourly: _globalController.getWeatherData().getHourlyWeather()),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
