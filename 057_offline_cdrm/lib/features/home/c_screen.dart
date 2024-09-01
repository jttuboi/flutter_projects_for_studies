import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/route_name.dart';
import '../../widgets/button.dart';
import '../../widgets/show_my_dialog.dart';
import 'screen_with_menu.dart';

class CScreen extends StatelessWidget {
  const CScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWithMenu(RouteName.c, contents: [
      Button.route(RouteName.ip, onTap: () => Modular.to.pushNamed('${RouteName.c.path}${RouteName.ip.path}')),
      Button.route(RouteName.s, onTap: () => Modular.to.pushNamed('${RouteName.c.path}${RouteName.s.path}')),
      Button.route(RouteName.f, onTap: () => Modular.to.pushNamed('${RouteName.c.path}${RouteName.f.path}')),
      Button.route(RouteName.fp, onTap: () => Modular.to.pushNamed('${RouteName.c.path}${RouteName.fp.path}')),
      Button.route(RouteName.ir, onTap: () => showMyDialog(context, RouteName.ir)),
      Button.route(RouteName.cp, onTap: () => showMyDialog(context, RouteName.cp)),
      Button.route(RouteName.tp, onTap: () => Modular.to.pushNamed('${RouteName.c.path}${RouteName.tp.path}')),
    ]);
  }
}
