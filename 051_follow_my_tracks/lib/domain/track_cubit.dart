import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_my_tracks/data/tracks_repository.dart';
import 'package:follow_my_tracks/domain/core.dart';
import 'package:follow_my_tracks/domain/track.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locator;

class TrackCubit extends Cubit<TrackState> {
  TrackCubit(this.repository) : super(TrackInitial());

  final TracksRepository repository;

  final _location = locator.Location();

  Future<void> initNewTrack() async {
    var _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == locator.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != locator.PermissionStatus.granted) {
        emit(TrackError('permissão de localização desativada,\nnão será possível carregar essa página.'));
      }
    }

    var _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        emit(TrackLoaded(defaultLocation));
      }
    }

    if (_serviceEnabled && _permissionGranted == locator.PermissionStatus.granted) {
      final currentLocation = await _location.getLocation();
      emit(TrackLoaded(LatLng(currentLocation.latitude!, currentLocation.longitude!)));
    }
  }

  Future<void> initWithLoadTrack(Track track) async {
    var _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == locator.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != locator.PermissionStatus.granted) {
        emit(TrackError('permissão de localização desativada,\nnão será possível carregar essa página.'));
      }
    }

    var _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        emit(TrackLoaded(track.markers.first.position));
      }
    }

    if (_serviceEnabled && _permissionGranted == locator.PermissionStatus.granted) {
      emit(TrackLoaded(track.markers.first.position));
    }
  }

  Future<void> goToDeviceLocation() async {
    final locationData = await _location.getLocation();
    emit(TrackUpdateCameraPosition(LatLng(locationData.latitude!, locationData.longitude!)));
  }

  Future<void> saveTrack(Track track) async {
    await repository.saveTrack(track);
  }
}

abstract class TrackState {}

class TrackInitial implements TrackState {}

class TrackLoaded implements TrackState {
  TrackLoaded(this.cameraPosition);
  final LatLng cameraPosition;
}

class TrackUpdateCameraPosition implements TrackState {
  TrackUpdateCameraPosition(this.cameraPosition);
  final LatLng cameraPosition;
}

class TrackError implements TrackState {
  TrackError(this.message);
  final String message;
}
