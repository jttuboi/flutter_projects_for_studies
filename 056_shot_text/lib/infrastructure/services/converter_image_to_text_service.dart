import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:shot_text/domain/services/converter_image_to_text_service.dart';

class ConverterImageToTextService implements IConverterImageToTextService {
  @override
  Future<String> convert(File image) async {
    log('=====================');
    log(image.uri.toString());
    log(image.path);

    final inputImage = InputImage.fromFile(image);

// ignore_for_file: prefer_interpolation_to_compose_strings, omit_local_variable_types, prefer_final_in_for_each, unused_local_variable, use_string_buffers, prefer_final_locals
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText = await textDetector.processImage(inputImage);
    String text = recognisedText.text;
    log(text);
    log('---------------------');
    var saida = '';
    for (TextBlock block in recognisedText.blocks) {
      final Rect rect = block.rect;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          log(element.text);
          saida += ' ' + element.text;
        }
      }
    }
    log('=====================');

    await textDetector.close();

    return Future.value(saida);
  }
}
// https://developers.google.com/ml-kit/guides
// https://developers.google.com/ml-kit/vision/text-recognition/android
// https://github.com/bharat-biradar/Google-Ml-Kit-plugin (tentar implementar sem a ajuda de packages externos)
// https://pub.dev/packages/google_ml_kit

// https://pub.dev/packages/flutter_tesseract_ocr





//https://blog.logrocket.com/flutter-camera-plugin-deep-dive-with-examples/
//////////////////////// CameraImage 
///https://pub.dev/packages/camera
// final camera; // your camera instance
// final WriteBuffer allBytes = WriteBuffer();
// for (Plane plane in cameraImage.planes) {
//   allBytes.putUint8List(plane.bytes);
// }
// final bytes = allBytes.done().buffer.asUint8List();

// final Size imageSize = Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

// final InputImageRotation imageRotation =
//     InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
//         InputImageRotation.Rotation_0deg;

// final InputImageFormat inputImageFormat =
//     InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
//         InputImageFormat.NV21;

// final planeData = cameraImage.planes.map(
//   (Plane plane) {
//     return InputImagePlaneMetadata(
//       bytesPerRow: plane.bytesPerRow,
//       height: plane.height,
//       width: plane.width,
//     );
//   },
// ).toList();

// final inputImageData = InputImageData(
//   size: imageSize,
//   imageRotation: imageRotation,
//   inputImageFormat: inputImageFormat,
//   planeData: planeData,
// );

// final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
