import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shot_text/presentation/camera_shot/cubit/shot_result_cubit.dart';
import 'package:shot_text/presentation/camera_shot/theme.dart';
import 'package:shot_text/presentation/camera_shot/widgets/shot_icon_button.dart';
import 'package:shot_text/presentation/camera_shot/widgets/shot_result_background.dart';
import 'package:shot_text/presentation/camera_shot/widgets/shot_text_button.dart';

class ShotResultReadyView extends StatefulWidget {
  const ShotResultReadyView({required this.imagePath, required this.text, Key? key}) : super(key: key);

  final String imagePath;
  final String text;

  @override
  State<ShotResultReadyView> createState() => _ShotResultReadyViewState();
}

class _ShotResultReadyViewState extends State<ShotResultReadyView> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ShotResultBackground(imagePath: widget.imagePath, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height),
            Positioned(
              top: 0,
              left: 0,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        textSelectionTheme: TextSelectionThemeData(
                          selectionColor: Colors.grey.withOpacity(0.7),
                          selectionHandleColor: Colors.amber,
                          cursorColor: Colors.white,
                        ),
                      ),
                      child: TextField(
                        controller: _textEditingController,
                        minLines: 1,
                        maxLines: 5,
                        decoration: textFieldDecoration,
                        style: textFieldStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShotIconButton(
                        tooltip: 'Open in browser',
                        icon: Icons.open_in_browser_rounded,
                        onPressed: () => ReadContext(context).read<ShotResultCubit>().urlOpened(_textEditingController.text),
                      ),
                      const SizedBox(width: 8),
                      ShotIconButton(
                        tooltip: 'Copy to clipboard',
                        icon: Icons.content_copy_rounded,
                        onPressed: () => ReadContext(context).read<ShotResultCubit>().textCopied(_textEditingController.text),
                      ),
                      const SizedBox(width: 8),
                      ShotIconButton(
                        tooltip: 'Share to',
                        icon: Icons.share_rounded,
                        onPressed: () => ReadContext(context).read<ShotResultCubit>().textShared(_textEditingController.text),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ShotTextButton(
                    text: 'Try another shot.',
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
