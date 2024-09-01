import 'package:flutter/material.dart';

import '../utils/strings.dart';

class CTextTile extends StatelessWidget {
  const CTextTile({required this.title, required this.text, super.key});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(text: Strings.cTextTileTitle(title), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), children: [
      TextSpan(text: text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
    ]));
  }
}
