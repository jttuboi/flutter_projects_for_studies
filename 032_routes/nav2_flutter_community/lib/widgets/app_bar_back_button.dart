import 'package:nav2_flutter_community/common/extensions/color_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? SizedBox.shrink() : BackButton(color: color.onTextColor());
  }
}
