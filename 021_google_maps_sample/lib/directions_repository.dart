import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_sample/.env.dart';
import 'package:google_maps_sample/directions_model.dart';

class DirectionRepository {
  DirectionRepository({required this.dio});

  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio dio;

  Future<Directions> getDirections({required LatLng origin, required LatLng destination}) async {
    final response = await dio.get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': googleAPIKey,
    });

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return Directions.empty();
  }
}
