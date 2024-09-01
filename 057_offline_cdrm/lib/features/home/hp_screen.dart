import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/route_name.dart';
import '../../widgets/button.dart';
import 'screen_with_menu_and_tab.dart';

class HpScreen extends StatelessWidget {
  const HpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWithMenuAndTab(
      RouteName.hp,
      tabs: const ['L', 'M'],
      contentsTab1: [
        Button.label('1', onTap: () => Modular.to.pushNamed(RouteName.hpd.path.replaceAll(':id', '1'))),
      ],
    );
  }
}
