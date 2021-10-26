// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:meta_weather_api/meta_weather_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('MetaWeatherApiClient', () {
    late http.Client httpClient;
    late MetaWeatherApiClient metaWeatherApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      metaWeatherApiClient = MetaWeatherApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(MetaWeatherApiClient(), isNotNull);
      });
    });

    group('licationSearch', () {
      const query = 'mock-query';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('[]');
        when(() => httpClient.get(any())).thenAnswer((invocation) async => response);
        try {
          await metaWeatherApiClient.locationSearch(query);
        } catch (e) {}

        verify(() => httpClient.get(Uri.https('www.metaweather.com', '/api/location/search', {'query': query}))).called(1);
      });

      test('throws LocationIdRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((invocation) async => response);

        expect(() async => await metaWeatherApiClient.locationSearch(query), throwsA(isA<LocationIdRequestFailure>()));
      });

      test('throws LocationNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('[]');
        when(() => httpClient.get(any())).thenAnswer((invocation) async => response);

        await expectLater(metaWeatherApiClient.locationSearch(query), throwsA(isA<LocationNotFoundFailure>()));
      });

      test('returns Location on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''[{
            "title": "mock-title",
            "location_type": "City",
            "latt_long": "-34.75,83.28",
            "woeid": 42
          }]''',
        );
        when(() => httpClient.get(any())).thenAnswer((invocation) async => response);

        final actual = await metaWeatherApiClient.locationSearch(query);
        expect(
          actual,
          isA<Location>()
              .having((location) => location.title, 'title', 'mock-title')
              .having((location) => location.locationType, 'type', LocationType.city)
              .having(
                (location) => location.latLng,
                'latLng',
                isA<LatLng>().having((latLng) => latLng.latitude, 'latitude', -34.75).having((latLng) => latLng.longitude, 'longitude', 83.28),
              )
              .having((location) => location.woeid, 'woeid', 42),
        );
      });
    });
    group('getWeather', () {
      const locationId = 42;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((invocation) async => response);
        try {
          await metaWeatherApiClient.getWeather(locationId);
        } catch (e) {}

        verify(() => httpClient.get(Uri.https('www.metaweather.com', '/api/location/$locationId'))).called(1);
      });

      test('throws WeatherRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((invocation) async => response);

        expect(() async => await metaWeatherApiClient.getWeather(locationId), throwsA(isA<WeatherRequestFailure>()));
      });

      test('throws WeatherNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((invocation) async => response);

        expect(() async => await metaWeatherApiClient.getWeather(locationId), throwsA(isA<WeatherNotFoundFailure>()));
      });

      test('throws WeatherNotFoundFailure on empty consolidated weather', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"consolidated_weather": []}');
        when(() => httpClient.get(any())).thenAnswer((invocation) async => response);

        expect(() async => await metaWeatherApiClient.getWeather(locationId), throwsA(isA<WeatherNotFoundFailure>()));
      });

      test('returns weather on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
          {"consolidated_weather":[{
            "id":4907479830888448,
            "weather_state_name":"Showers",
            "weather_state_abbr":"s",
            "wind_direction_compass":"SW",
            "created":"2020-10-26T00:20:01.840132Z",
            "applicable_date":"2020-10-26",
            "min_temp":7.9399999999999995,
            "max_temp":13.239999999999998,
            "the_temp":12.825,
            "wind_speed":7.876886316914553,
            "wind_direction":246.17046093256732,
            "air_pressure":997.0,
            "humidity":73,
            "visibility":11.037727173307882,
            "predictability":73
          }]}
        ''');
        when(() => httpClient.get(any())).thenAnswer((invocation) async => response);
        final actual = await metaWeatherApiClient.getWeather(locationId);

        expect(
          actual,
          isA<Weather>()
              .having((weather) => weather.id, 'id', 4907479830888448)
              .having((weather) => weather.weatherStateName, 'state', 'Showers')
              .having((weather) => weather.weatherStateAbbr, 'abbr', WeatherState.showers)
              .having((weather) => weather.windDirectionCompass, 'wind', WindDirectionCompass.southWest)
              .having((weather) => weather.created, 'created', DateTime.parse('2020-10-26T00:20:01.840132Z'))
              .having((weather) => weather.applicableDate, 'applicableDate', DateTime.parse('2020-10-26'))
              .having((weather) => weather.minTemp, 'minTemp', 7.9399999999999995)
              .having((weather) => weather.maxTemp, 'maxTemp', 13.239999999999998)
              .having((weather) => weather.theTemp, 'theTemp', 12.825)
              .having((weather) => weather.windSpeed, 'windSpeed', 7.876886316914553)
              .having((weather) => weather.windDirection, 'windDirection', 246.17046093256732)
              .having((weather) => weather.airPressure, 'airPressure', 997.0)
              .having((weather) => weather.humidity, 'humidity', 73)
              .having((weather) => weather.visibility, 'visibility', 11.037727173307882)
              .having((weather) => weather.predictability, 'predictability', 73),
        );
      });
    });
  });
}
