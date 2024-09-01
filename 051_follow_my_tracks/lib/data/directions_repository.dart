import 'package:dio/dio.dart';
import 'package:follow_my_tracks/domain/core.dart';
import 'package:follow_my_tracks/domain/directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  DirectionsRepository({required this.dio});

  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio dio;

  Future<Directions> getDirections({required LatLng origin, required LatLng destination}) async {
    // https://developers.google.com/maps/documentation/directions/get-directions
    final response = await dio.get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'mode': 'walking',
      'key': googleAPIKey,
    });

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return Directions.empty();
  }
}
