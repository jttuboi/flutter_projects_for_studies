import 'package:nav2_flutter_community/common/dimens/app_dimens.dart';
import 'package:flutter/cupertino.dart';

const String BEVELED_SHAPE = "beveled";
const String CIRCLE_SHAPE = "circle";
const String CONTINUOUS_SHAPE = "continuous";
const String ROUNDED_SHAPE = "rounded";
const String STADIUM_SHAPE = "stadium";

enum ShapeBorderType { BEVELED, CONTINUOUS, ROUNDED, STADIUM, CIRCLE }

extension ShapeBorderTypeExtensions on ShapeBorderType {
  String stringRepresentation() {
    switch (this) {
      case ShapeBorderType.CONTINUOUS:
        return CONTINUOUS_SHAPE;
      case ShapeBorderType.BEVELED:
        return BEVELED_SHAPE;
      case ShapeBorderType.ROUNDED:
        return ROUNDED_SHAPE;
      case ShapeBorderType.STADIUM:
        return STADIUM_SHAPE;
      case ShapeBorderType.CIRCLE:
        return CIRCLE_SHAPE;
    }
  }

  ShapeBorder getShapeBorder() {
    switch (this) {
      case ShapeBorderType.CONTINUOUS:
        return ContinuousRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.SIZE_SPACING_LARGE));
      case ShapeBorderType.BEVELED:
        return BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppDimens.SIZE_SPACING_LARGE)));
      case ShapeBorderType.ROUNDED:
        return RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppDimens.SIZE_SPACING_LARGE)));
      case ShapeBorderType.STADIUM:
        return StadiumBorder();
      case ShapeBorderType.CIRCLE:
        return CircleBorder();
    }
  }
}
