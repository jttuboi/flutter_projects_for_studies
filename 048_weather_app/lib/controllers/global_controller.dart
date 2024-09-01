import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/services/fetch_weather.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  final _weatherData = const WeatherData().obs;

  @override
  Future<void> onInit() async {
    if (_isLoading.isTrue) {
      await getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  RxBool checkLoading() => _isLoading;

  RxDouble getLatitude() => _latitude;

  RxDouble getLongitude() => _longitude;

  RxInt getIndex() => _currentIndex;

  WeatherData getWeatherData() => _weatherData.value;

  Future<void> getLocation() async {
    bool isLocationEnabled;
    LocationPermission locationPermission;

    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return Future.error('Location not enabled');
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location permission are denied forever');
    } else //
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permission is denied');
      }
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;

      return FetchWeatherAPI().processData(_latitude.value, _longitude.value).then((value) {
        _weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }
}
