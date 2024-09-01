import 'package:flutter/material.dart';

import '../utils/strings.dart';

class COutdatedDataInfo extends StatelessWidget {
  const COutdatedDataInfo({this.text = '', super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.red.shade200,
      child: Text((text.isNotEmpty) ? text : Strings.cOutdatedDataInfoDefaultText),
    );
  }
}
