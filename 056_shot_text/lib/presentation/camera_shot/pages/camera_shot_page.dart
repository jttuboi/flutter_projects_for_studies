import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shot_text/presentation/camera_shot/pages/shot_result_page.dart';
import 'package:shot_text/presentation/camera_shot/widgets/shot_text_button.dart';

class CameraShotPage extends StatefulWidget {
  const CameraShotPage({Key? key}) : super(key: key);

  static String routeName = '/';

  @override
  _CameraShotPageState createState() => _CameraShotPageState();
}

class _CameraShotPageState extends State<CameraShotPage> {
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _startCamera(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: ShotTextButton(text: 'Open camera', onPressed: () => _startCamera(context)));
  }

  Future<void> _startCamera(BuildContext context) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );
      if (!mounted) {
        return;
      }
      if (pickedFile != null) {
        await Modular.to.pushNamed(ShotResultPage.routeName, arguments: pickedFile.path);
      }
    } on PlatformException catch (e, s) {
      // TODO arrumar essa parte do error,
      // The method could throw [PlatformException] if the app does not have permission to access the camera or photos gallery,
      // no camera is available, plugin is already in use, temporary file could not be created (iOS only), plugin activity
      // could not be allocated (Android only) or due to an unknown error.
      log('Error, user dont allow the permission to access the camera or photo gallery', error: e, stackTrace: s);
    }
  }
}
