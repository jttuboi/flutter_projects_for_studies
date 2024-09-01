import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:follow_my_tracks/domain/marker_map_cubit.dart';
import 'package:follow_my_tracks/domain/track_cubit.dart';
import 'package:follow_my_tracks/presentation/save_alert_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({required this.title, required this.onInit, this.trackName = '', Key? key}) : super(key: key);

  final String title;
  final String trackName;
  final VoidCallback onInit;

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
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
    return BlocConsumer<TrackCubit, TrackState>(
      listener: (context, trackState) {
        if (trackState is TrackError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(trackState.message)));
        }
        if (trackState is TrackUpdateCameraPosition) {
          _changeLocation(trackState.cameraPosition);
        }
      },
      buildWhen: (previous, current) {
        return current is! TrackError && current is! TrackUpdateCameraPosition;
      },
      builder: (context, trackState) {
        if (trackState is TrackInitial) {
          widget.onInit();
          return _buildLoading();
        }
        return Scaffold(
          appBar: _buildAppBar(actions: [
            InkWell(
              onTap: () => _onTapSaveButton(context),
              child: const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Icon(Icons.save)),
            )
          ]),
          body: Stack(
            children: [
              BlocBuilder<MarkersCubit, MarkersState>(
                builder: (context, markersState) {
                  markersState = markersState as MarkersUpdated;
                  return _buildMap((trackState as TrackLoaded).cameraPosition, markersState.markers, markersState.polylines, context);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: AddressTextField(onAddressFound: (position) async {
                  await _changeLocation(position);
                }),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.read<TrackCubit>().goToDeviceLocation(),
            child: const Icon(Icons.location_searching),
          ),
        );
      },
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildMap(LatLng cameraPosition, List<Marker> markers, List<Polyline> polylines, BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      buildingsEnabled: false,
      compassEnabled: false,
      mapToolbarEnabled: false,
      padding: const EdgeInsets.only(top: 56),
      initialCameraPosition: CameraPosition(target: cameraPosition, zoom: 18),
      markers: Set.of(markers),
      polylines: Set.of(polylines),
      onMapCreated: (controller) => _googleMapController = controller,
      onTap: context.read<MarkersCubit>().addMarker,
    );
  }

  PreferredSizeWidget _buildAppBar({List<Widget>? actions}) {
    return AppBar(title: Text(widget.title), actions: actions);
  }

  void _onTapSaveButton(BuildContext context) {
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (context1) {
        return SaveAlertDialog(
          trackName: widget.trackName,
          markers: context.read<MarkersCubit>().markers,
          polylines: context.read<MarkersCubit>().polylines,
          onSaveClicked: (track) async {
            await context.read<TrackCubit>().saveTrack(track).then((value) {
              Navigator.of(context, rootNavigator: true).pop(true);
            });
          },
        );
      },
    ).then((isSaved) {
      if (isSaved != null && isSaved) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    });
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

class AddressTextField extends StatefulWidget {
  const AddressTextField({required this.onAddressFound, Key? key}) : super(key: key);

  final Function(LatLng) onAddressFound;

  @override
  State<AddressTextField> createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
  final addressController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 2))],
      ),
      child: TextField(
        controller: addressController,
        decoration: InputDecoration(
          hintText: 'Address',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: _onSearchPressed,
          ),
        ),
      ),
    );
  }

  Future<void> _onSearchPressed() async {
    final locations = await locationFromAddress(addressController.text.trim());
    if (locations.isNotEmpty) {
      final location = locations.first;
      widget.onAddressFound(LatLng(location.latitude, location.longitude));
    } else {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('address ${addressController.text.trim()} not found')));
    }
  }
}
