import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class MaskedImage extends StatelessWidget {
  MaskedImage({required this.asset, required this.mask});

  final String asset;
  final String mask;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return FutureBuilder<List>(
        future: _createShaderAndImage(
          asset,
          mask,
          constraints.maxWidth,
          constraints.maxWidth,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          return ShaderMask(
            blendMode: BlendMode.dstATop,
            shaderCallback: (rect) => snapshot.data![0],
            child: snapshot.data![1],
          );
        },
      );
    });
  }

  Future<List> _createShaderAndImage(
      String asset, String mask, double width, double height) async {
    ByteData assetData = await rootBundle.load(asset);
    ByteData maskData = await rootBundle.load(mask);
    print("$width, $height");
    Codec codec = await instantiateImageCodec(
      maskData.buffer.asUint8List(),
      targetWidth: width.toInt(),
      targetHeight: height.toInt(),
    );
    FrameInfo fi = await codec.getNextFrame();

    ImageShader shader = ImageShader(
      fi.image,
      TileMode.clamp,
      TileMode.clamp,
      Matrix4.identity().storage,
    );

    Image image = Image.memory(
      assetData.buffer.asUint8List(),
      fit: BoxFit.cover,
      width: width,
      height: height,
    );

    return [shader, image];
  }
}


  // @override
  // Widget build(BuildContext context) {
  //   return LayoutBuilder(builder: (context, constraints) {
  //     return FutureBuilder<List>(
  //       future: _createShaderAndImage(
  //         asset,
  //         mask,
  //         constraints.maxWidth,
  //         constraints.maxHeight,
  //       ),
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return const SizedBox.shrink();
  //         }
  //         return ShaderMask(
  //           blendMode: BlendMode.dstATop,
  //           shaderCallback: (rect) => snapshot.data![0],
  //           child: snapshot.data![1],
  //         );
  //       },
  //     );
  //   });
  // }