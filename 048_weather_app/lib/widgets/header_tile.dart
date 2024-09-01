import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/global_controller.dart';

class HeaderTile extends StatefulWidget {
  const HeaderTile({super.key});

  @override
  State<HeaderTile> createState() => _HeaderTileState();
}

class _HeaderTileState extends State<HeaderTile> {
  final _globalController = Get.put(GlobalController(), permanent: true);
  String _city = '';
  final String _date = DateFormat('yMMMMd').format(DateTime.now());

  @override
  void initState() {
    _getAddress(_globalController.getLatitude().value, _globalController.getLongitude().value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(_city, style: const TextStyle(fontSize: 35, height: 2)),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(_date, style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5)),
        ),
      ],
    );
  }

  Future<void> _getAddress(double latitude, double longitude) async {
    List<Placemark> placemark = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemark[0];
    setState(() {
      _city = place.locality!;
    });
  }
}
