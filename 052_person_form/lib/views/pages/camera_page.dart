import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage._(List<CameraDescription> cameras, {Key? key})
      : _cameras = cameras,
        super(key: key);

  static const routeName = '/camera';
  static Route route(List<CameraDescription>? cameras) {
    return MaterialPageRoute(builder: (context) => CameraPage._(cameras ?? []));
  }

  final List<CameraDescription> _cameras;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final cameraShotSize = 50.0;
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();

    if (_cameraController == null) {
      final frontCamera = widget._cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
      _cameraController = CameraController(frontCamera, ResolutionPreset.high);
      _cameraController!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).onError((error, stackTrace) {
        // caso não aceite, apenas volta para o person form
        Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    if (_cameraController != null) {
      _cameraController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Container();
    }

    return AspectRatio(
      aspectRatio: _cameraController!.value.aspectRatio,
      child: Stack(
        children: [
          CameraPreview(_cameraController!),
          Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width / 2 - cameraShotSize / 2,
            child: Material(
              color: Colors.transparent,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(10)),
                child: Icon(Icons.camera, size: cameraShotSize),
                onPressed: () async => await _takePicture(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _takePicture(BuildContext context) async {
    final xFile = await _cameraController!.takePicture();
    final croppedFile = await _cropImage(xFile);
    Navigator.pop(context, croppedFile);
  }

  Future<File?> _cropImage(XFile xFile) async {
    return await ImageCropper.cropImage(
      compressQuality: 50,
      maxHeight: 128,
      maxWidth: 128,
      sourcePath: File(xFile.path).path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      androidUiSettings: const AndroidUiSettings(
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: true,
      ),
    );
  }
}
