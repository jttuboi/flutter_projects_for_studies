import 'package:flutter/material.dart';

import '../../utils/route_name.dart';
import 'screen_with_menu.dart';

class HpDScreen extends StatelessWidget {
  const HpDScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return ScreenWithMenu(RouteName.hpd, contents: [
      Text(id),
    ]);
  }
}
