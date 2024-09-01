import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shot_text/presentation/camera_shot/widgets/shot_result_background.dart';
import 'package:shot_text/presentation/camera_shot/widgets/shot_text_button.dart';

class ShotResultErrorView extends StatelessWidget {
  const ShotResultErrorView({required this.imagePath, Key? key}) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ShotResultBackground(imagePath: imagePath, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height),
            Positioned(
              top: 0,
              left: 0,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShotTextButton(
                    text: 'Text not found.\nTry another shot.',
                    onPressed: () => Modular.to.pop(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
