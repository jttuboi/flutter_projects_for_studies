import 'package:flutter/material.dart';
import 'package:visual_1/utils/constants.dart';

class CButton extends StatelessWidget {
  const CButton(this.data, {this.style = const CButtonStyle.primary(), this.onTap = emptyFunction, super.key});

  final CButtonData data;
  final CButtonStyle style;
  final FunctionCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CButtonData {
  const CButtonData({required this.text});

  final String text;
}

class CButtonStyle {
  const CButtonStyle.primary();

  const CButtonStyle.secondary();

  const CButtonStyle.tertiary();
}
