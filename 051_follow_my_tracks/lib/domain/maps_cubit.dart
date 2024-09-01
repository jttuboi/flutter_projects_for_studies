import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_my_tracks/domain/core.dart';
import 'package:follow_my_tracks/domain/track.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locator;

class MapsCubit extends Cubit<MapsState> {
  MapsCubit() : super(MapsInitial());

  final _location = locator.Location();

  Future<void> initMap() async {
    var _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == locator.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != locator.PermissionStatus.granted) {
        emit(MapsError('permissão de localização desativada,\nnão será possível carregar essa página.'));
      }
    }

    var _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        emit(MapsLoaded(defaultLocation, [], []));
      }
    }

    if (_serviceEnabled && _permissionGranted == locator.PermissionStatus.granted) {
      final currentLocation = await _location.getLocation();
      emit(MapsLoaded(LatLng(currentLocation.latitude!, currentLocation.longitude!), [], []));
    }
  }

  Future<void> refreshWithTrack(Track track) async {
    if (track.markers.isNotEmpty) {
      emit(MapsLoaded(LatLng(track.markers.first.position.latitude, track.markers.first.position.longitude), track.markers, track.polylines));
    } else {
      final currentLocation = await _location.getLocation();
      emit(MapsLoaded(LatLng(currentLocation.latitude!, currentLocation.longitude!), [], []));
    }
  }

  Future<void> goToDeviceLocation() async {
    final locationData = await _location.getLocation();
    emit(MapsUpdateCameraPosition(LatLng(locationData.latitude!, locationData.longitude!)));
  }
}

abstract class MapsState {}

class MapsInitial implements MapsState {}

class MapsLoaded implements MapsState {
  MapsLoaded(this.cameraPosition, this.markers, this.polylines);
  final LatLng cameraPosition;
  final List<Marker> markers;
  final List<Polyline> polylines;
}

class MapsUpdateCameraPosition implements MapsState {
  MapsUpdateCameraPosition(this.cameraPosition);
  final LatLng cameraPosition;
}

class MapsError implements MapsState {
  MapsError(this.message);
  final String message;
}
