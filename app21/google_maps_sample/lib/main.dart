import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_sample/directions_model.dart';
import 'package:google_maps_sample/directions_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _initialCameraPosition = const CameraPosition(target: LatLng(-23.55044518655175, -46.63390570025485), zoom: 11.5);
  late GoogleMapController _googleMapController;

  Directions? _directions;
  Marker? _origin;
  Marker? _destination;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).primaryTextTheme.headline6,
        centerTitle: false,
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _goToPosition(_origin!),
              style: TextButton.styleFrom(primary: Colors.green, textStyle: const TextStyle(fontWeight: FontWeight.w600)),
              child: const Text('ORIGIN'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _goToPosition(_destination!),
              style: TextButton.styleFrom(primary: Colors.blue, textStyle: const TextStyle(fontWeight: FontWeight.w600)),
              child: const Text('DEST'),
            ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_origin != null) _origin!,
              if (_destination != null) _destination!,
            },
            onLongPress: _addMarker,
            polylines: {
              if (_directions != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _directions!.polylinePoints.map((point) => LatLng(point.latitude, point.longitude)).toList(),
                )
            },
          ),
          if (_directions != null)
            Positioned(
              top: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    )
                  ],
                ),
                child: Text(
                  '${_directions!.totalDistance}, ${_directions!.totalDuration}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: _resetCameraPosition,
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _goToPosition(Marker marker) {
    _googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: marker.position, zoom: 14.5, tilt: 50),
      ),
    );
  }

  void _resetCameraPosition() {
    _googleMapController.animateCamera(
      _directions != null ? CameraUpdate.newLatLngBounds(_directions!.bounds, 100) : CameraUpdate.newCameraPosition(_initialCameraPosition),
    );
  }

  Future<void> _addMarker(LatLng clickedPosition) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: clickedPosition,
        );
        _destination = null;
        _directions = null;
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: clickedPosition,
        );
      });

      final directions = await DirectionRepository(dio: Dio()).getDirections(origin: _origin!.position, destination: _destination!.position);
      setState(() {
        _directions = directions;
      });
    }
  }
}
