import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class MaskedImage2 extends StatelessWidget {
  const MaskedImage2({required this.asset, required this.mask});

  final String asset;
  final String mask;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: _createShaderAndImage(asset, mask),
      builder: (context, snapshot) {
        return CustomPaint(
          painter: OverlayPainter(snapshot.data![0], snapshot.data![1]),
        );
      },
    );
  }

  Future<List> _createShaderAndImage(String asset, String mask) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();

    // ByteData data2 = await rootBundle.load(mask);
    // ui.Codec codec2 = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi2 = await codec.getNextFrame();

    return [fi.image, fi2.image];
  }
}

class OverlayPainter extends CustomPainter {
  OverlayPainter(this.asset, this.shader);
  final ui.Image asset;
  final ui.Image shader;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(asset, Offset(0.0, 0.0), new Paint());

    canvas.drawImage(shader, Offset(0.0, 0.0), new Paint());
  }

  @override
  bool shouldRepaint(OverlayPainter oldDelegate) {
    return shader != oldDelegate.shader || asset != oldDelegate.asset;
  }
}
