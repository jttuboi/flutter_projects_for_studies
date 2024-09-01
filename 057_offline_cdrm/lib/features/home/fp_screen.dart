import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/route_name.dart';
import '../../widgets/button.dart';
import 'screen_with_menu.dart';

class FpScreen extends StatelessWidget {
  const FpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWithMenu(RouteName.fp, contents: [
      Button.route(RouteName.cfp, onTap: () => Modular.to.pushNamed('${RouteName.c.path}${RouteName.cfp.path}')),
    ]);
  }
}
