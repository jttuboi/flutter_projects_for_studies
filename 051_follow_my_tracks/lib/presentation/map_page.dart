import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_my_tracks/domain/maps_cubit.dart';
import 'package:follow_my_tracks/domain/track.dart';
import 'package:follow_my_tracks/presentation/routes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _googleMapController;

  @override
  void dispose() {
    if (_googleMapController != null) {
      _googleMapController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is MapsError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is MapsUpdateCameraPosition) {
          _changeLocation(state.cameraPosition);
        }
      },
      buildWhen: (previous, current) {
        return current is! MapsError && current is! MapsUpdateCameraPosition;
      },
      builder: (context, state) {
        if (state is MapsInitial) {
          context.read<MapsCubit>().initMap();
          return _buildLoading();
        }
        final stateLoaded = state as MapsLoaded;
        return _buildMap(stateLoaded.cameraPosition, stateLoaded.markers, stateLoaded.polylines, context);
      },
    );
  }

  Widget _buildLoading() => const Scaffold(body: Center(child: CircularProgressIndicator()));

  Widget _buildMap(LatLng currentPosition, List<Marker> markers, List<Polyline> polylines, BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        buildingsEnabled: false,
        compassEnabled: false,
        mapToolbarEnabled: false,
        padding: const EdgeInsets.only(top: 56),
        initialCameraPosition: CameraPosition(target: currentPosition, zoom: 18),
        markers: Set.of(markers),
        polylines: Set.of(polylines),
        onMapCreated: (controller) => _googleMapController = controller,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'tracks',
            onPressed: () => _showTracks(context),
            child: const Icon(Icons.timeline_outlined),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'go_to_device_location',
            onPressed: () => context.read<MapsCubit>().goToDeviceLocation(),
            child: const Icon(Icons.location_searching),
          ),
        ],
      ),
    );
  }

  Future<void> _showTracks(BuildContext context) async {
    final track = await Navigator.pushNamed(context, tracksRoute);
    if (track != null) {
      if (!mounted) {
        return;
      }
      await context.read<MapsCubit>().refreshWithTrack(track as Track);
    }
  }

  Future<void> _changeLocation(LatLng toPosition) async {
    if (_googleMapController != null) {
      await _googleMapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: toPosition,
        zoom: 18,
      )));
    }
  }
}
