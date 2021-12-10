import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite_test/models/contact_model.dart';
import 'package:sqflite_test/repositories/address_repository.dart';
import 'package:sqflite_test/repositories/contact_repository.dart';
import 'package:uuid/uuid.dart';

class AddressView extends StatefulWidget {
  const AddressView({required this.model, Key? key}) : super(key: key);

  final ContactModel model;

  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final AddressRepository _addressRepository = AddressRepository();
  final ContactRepository _contactRepository = ContactRepository();

  Set<Marker> markers = <Marker>{};
  late GoogleMapController mapController;
  LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  void initState() {
    super.initState();
    if (widget.model.latLng.isNotEmpty) {
      var values = widget.model.latLng.split(',');
      _center = LatLng(
        double.parse(values[0]),
        double.parse(values[1]),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setMapPosition(widget.model.addressLine2, widget.model.addressLine1);
  }

  onSearch(address) {
    _addressRepository.searchAdress(address).then((data) {
      _center = LatLng(
        data['lat'],
        data['long'],
      );

      widget.model.addressLine1 = data['addressLine1'];
      widget.model.addressLine2 = data['addressLine2'];
      widget.model.latLng = "${data['lat']},${data['long']}";

      setMapPosition(data['addressLine2'], data['addressLine1']);
    }).catchError((e, s) {
      log('', error: e, stackTrace: s);
    });
  }

  setCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _center = LatLng(
      position.latitude,
      position.longitude,
    );

    setMapPosition("balta.io", "Posição Atual");
  }

  setMapPosition(title, snippet) {
    mapController.animateCamera(CameraUpdate.newLatLng(_center));
    markers = <Marker>{};

    const uuid = Uuid();
    Marker marker = Marker(
      markerId: MarkerId(uuid.v4()),
      position: _center,
      infoWindow: InfoWindow(
        title: title,
        snippet: snippet,
      ),
    );

    markers.add(marker);
    setState(() {});
  }

  updateContactInfo() {
    _contactRepository
        .updateAddress(
          widget.model.id,
          widget.model.addressLine1,
          widget.model.addressLine2,
          widget.model.latLng,
        )
        .then((_) => onSuccess())
        .catchError((_) => onError());
  }

  onSuccess() {
    Navigator.pop(context);
  }

  onError() {
    // Exibir snackbar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Endereço do Contato"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [IconButton(icon: const Icon(Icons.save), onPressed: updateContactInfo)],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: ListTile(
              title: const Text("Endereço atual", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.model.addressLine1, style: const TextStyle(fontSize: 12)),
                  Text(widget.model.addressLine2, style: const TextStyle(fontSize: 12)),
                ],
              ),
              isThreeLine: true,
            ),
          ),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                decoration: const InputDecoration(labelText: "Pesquisar..."),
                onSubmitted: onSearch,
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: markers,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: setCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
