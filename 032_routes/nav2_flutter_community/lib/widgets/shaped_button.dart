import 'package:nav2_flutter_community/common/dimens/app_dimens.dart';
import 'package:nav2_flutter_community/common/model/shape_border_type.dart';
import 'package:nav2_flutter_community/common/widgets/colored_text.dart';
import 'package:flutter/material.dart';

class ShapedButton extends StatelessWidget {
  const ShapedButton({
    required this.color,
    required this.shapeBorderType,
    this.onPressed,
    this.text,
    Key? key,
  }) : super(key: key);

  final Color color;
  final ShapeBorderType shapeBorderType;
  final VoidCallback? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_LARGE),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: shapeBorderType.getShapeBorder() as OutlinedBorder?,
        ),
        onPressed: onPressed == null ? () {} : onPressed,
        child: ColoredText(
          color: color,
          text: text ?? shapeBorderType.stringRepresentation(),
        ),
      ),
    );
  }
}
