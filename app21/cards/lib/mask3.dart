import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class MaskedImage3 extends StatelessWidget {
  MaskedImage3({required this.asset, required this.mask});

  final String asset;
  final String mask;

  @override
  Widget build(BuildContext context) {
    print("mask 2333333333333333333333333333333333333333");
    return LayoutBuilder(builder: (context, constraints) {
      return FutureBuilder<List>(
        future: _createShaderAndImage(
          asset,
          mask,
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
      String asset, String mask //, double width, double height
      ) async {
    ByteData assetData = await rootBundle.load(asset);
    ByteData maskData = await rootBundle.load(mask);
    //print("$width, $height");
    ui.Codec codec = await ui.instantiateImageCodec(
      maskData.buffer.asUint8List(),
      //targetWidth: width.toInt(),
      //targetHeight: height.toInt(),
    );
    ui.FrameInfo fi = await codec.getNextFrame();

    ImageShader shader = ImageShader(
      fi.image,
      TileMode.clamp,
      TileMode.clamp,
      Matrix4.identity().storage,
    );

    Image image = Image.memory(
      assetData.buffer.asUint8List(),
      //fit: BoxFit.cover,
      //width: width,
      //height: height,
    );

    return [shader, image];
  }
}






// class MaskedImage3 extends StatelessWidget {
//   MaskedImage3({required this.asset, required this.mask});

//   final String asset;
//   final String mask;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       return FutureBuilder<ui.Image>(
//         future: loadImage(mask),
//         builder: (context, snapshot) {
//           return ShaderMask(
//             blendMode: BlendMode.dstATop,
//             shaderCallback: (rect) => ImageShader(
//               snapshot.data!,
//               TileMode.mirror,
//               TileMode.mirror,
//               Float64List.fromList([1, 1, 0, 1, 1, 1, 1, 1, 0]),
//             ),
//              child: Image.asset(asset),
//           );
//         },
//       );
//     });
//   }

//   Future<ui.Image> loadImage(String imageUrl) async {
//     final ByteData data = await rootBundle.load(imageUrl);
//     Uint8List img = Uint8List.view(data.buffer);

//     final Completer<ui.Image> completer = new Completer();
//     ui.decodeImageFromList(img, (ui.Image result) {
//       return completer.complete(result);
//     });
//     return completer.future;
//   }

//   Future<List> _createShaderAndImage(
//       String asset, String mask, double width, double height) async {
//     ByteData assetData = await rootBundle.load(asset);
//     ByteData maskData = await rootBundle.load(mask);
//     print("$width, $height");
//     ui.Codec codec = await ui.instantiateImageCodec(
//       maskData.buffer.asUint8List(),
//       targetWidth: width.toInt(),
//       targetHeight: height.toInt(),
//     );
//     ui.FrameInfo fi = await codec.getNextFrame();

//     ImageShader shader = ImageShader(
//       fi.image,
//       TileMode.clamp,
//       TileMode.clamp,
//       Matrix4.identity().storage,
//     );

//     Image image = Image.memory(
//       assetData.buffer.asUint8List(),
//       fit: BoxFit.cover,
//       width: width,
//       height: height,
//     );

//     return [shader, image];
//   }
// }

// Future<List> _createShaderAndImage(
//       String asset, String mask, double width, double height) async {
//     ByteData assetData = await rootBundle.load(asset);
//     ByteData maskData = await rootBundle.load(mask);
//     print("$width, $height");
//     Codec codec = await instantiateImageCodec(
//       maskData.buffer.asUint8List(),
//       targetWidth: width.toInt(),
//       targetHeight: height.toInt(),
//     );
//     FrameInfo fi = await codec.getNextFrame();

//     ImageShader shader = ImageShader(
//       fi.image,
//       TileMode.clamp,
//       TileMode.clamp,
//       Matrix4.identity().storage,
//     );

//     Image image = Image.memory(
//       assetData.buffer.asUint8List(),
//       fit: BoxFit.cover,
//       width: width,
//       height: height,
//     );

//     return [shader, image];
//   }