import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Track extends Equatable {
  const Track({
    required this.name,
    this.imageUrl = 'image url vazia',
    this.markers = const [],
    this.polylines = const [],
  });

  const Track.empty()
      : name = '',
        imageUrl = 'image url vazia',
        markers = const [],
        polylines = const [];

  factory Track.copy(Track track) {
    return Track(
      name: track.name,
      imageUrl: track.imageUrl,
      markers: track.markers,
      polylines: track.polylines,
    );
  }

  final String name;
  final String imageUrl;
  final List<Marker> markers;
  final List<Polyline> polylines;

  bool get isEmpty {
    return name.isEmpty;
  }

  bool get isNotEmpty {
    return name.isNotEmpty;
  }

  @override
  String toString() {
    return 'Track($name, $imageUrl, $markers, $polylines)';
  }

  @override
  List<Object?> get props => [name, imageUrl, markers, polylines];
}
