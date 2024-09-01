import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_my_tracks/data/directions_repository.dart';
import 'package:follow_my_tracks/domain/directions.dart';
import 'package:follow_my_tracks/domain/track.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersCubit extends Cubit<MarkersState> {
  MarkersCubit(this._directionRepository) : super(MarkersUpdated([], []));

  final DirectionsRepository _directionRepository;
  final List<Marker> markers = [];
  final List<Polyline> polylines = [];

  void initWithLoadTrack(Track track) {
    markers.addAll(track.markers);
    polylines.addAll(track.polylines);
    emit(MarkersUpdated(markers, polylines));
  }

  Future<void> addMarker(LatLng clickedPosition) async {
    markers.add(_createMarker(clickedPosition, markers.length));
    await _addNewPolyline();
    emit(MarkersUpdated(markers, polylines));
  }

  Future<void> onTapMarkerToRemove(MarkerId markerId) async {
    markers.removeWhere((marker) => marker.markerId.value == markerId.value);
    _updateMarkersId();
    await _updatePolylines();
    emit(MarkersUpdated(markers, polylines));
  }

  Future<void> _addNewPolyline() async {
    if (_hasMarkersEnoughToMakePolylines) {
      final lastIndex = markers.length - 1;
      final directions = await _directionRepository.getDirections(origin: markers[lastIndex - 1].position, destination: markers[lastIndex].position);
      polylines.add(_createPolyline(directions, lastIndex - 1));
    }
  }

  void _updateMarkersId() {
    final newMarkers = <Marker>[];
    for (final oldMarker in markers) {
      newMarkers.add(_createMarker(oldMarker.position, newMarkers.length));
    }
    markers
      ..clear()
      ..addAll(newMarkers);
  }

  Future<void> _updatePolylines() async {
    polylines.clear();

    if (_hasMarkersEnoughToMakePolylines) {
      for (var i = 0; i < markers.length - 1; i++) {
        final directions = await _directionRepository.getDirections(origin: markers[i].position, destination: markers[i + 1].position);
        polylines.add(_createPolyline(directions, i));
      }
    }
  }

  Marker _createMarker(LatLng position, int index) {
    final markerId = MarkerId('$index');
    return Marker(
      markerId: markerId,
      infoWindow: InfoWindow(title: '${markers.length}'),
      onTap: () => onTapMarkerToRemove(markerId),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: position,
    );
  }

  Polyline _createPolyline(Directions directions, int index) {
    return Polyline(
      polylineId: PolylineId('$index'),
      color: Colors.green,
      width: 5,
      points: directions.polylinePoints.map((point) => LatLng(point.latitude, point.longitude)).toList(),
    );
  }

  bool get _hasMarkersEnoughToMakePolylines {
    return markers.length >= 2;
  }
}

abstract class MarkersState {}

class MarkersUpdated implements MarkersState {
  MarkersUpdated(this.markers, this.polylines);
  final List<Marker> markers;
  final List<Polyline> polylines;
}
