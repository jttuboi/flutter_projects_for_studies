import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/route_name.dart';
import '../../widgets/button.dart';
import '../../widgets/show_my_dialog.dart';
import '../init/authentication_change_notifier.dart';

class ScreenWithMenu extends StatelessWidget {
  const ScreenWithMenu(this.route, {this.contents = const [], super.key});

  final RouteName route;
  final List<Widget> contents;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(route.name), backgroundColor: route.color),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Column(children: [
              const Text('menu'),
              Button.route(RouteName.hm, onTap: (route == RouteName.hm) ? null : () => Modular.to.navigate(RouteName.hm.path)),
              Button.route(RouteName.pf, onTap: (route == RouteName.pf) ? null : () => Modular.to.navigate(RouteName.pf.path)),
              Button.route(RouteName.pl,
                  onTap: (route == RouteName.pl)
                      ? null
                      : () {
                          final userId = Modular.get<AuthenticationChangeNotifier>().userLogged;
                          Modular.to.navigate(RouteName.pl.path.replaceAll(':id', userId));
                        }),
              Button.route(RouteName.sd, onTap: (route == RouteName.sd) ? null : () => Modular.to.navigate(RouteName.sd.path)),
              Button.route(RouteName.hp, onTap: (route == RouteName.hp) ? null : () => Modular.to.navigate(RouteName.hp.path)),
              Button.route(RouteName.f, onTap: (route == RouteName.f) ? null : () => Modular.to.navigate(RouteName.f.path)),
              Button.route(RouteName.sl, onTap: (route == RouteName.sl) ? null : () => showMyDialog(context, RouteName.sl)),
              Button.route(RouteName.ht, onTap: (route == RouteName.ht) ? null : () => Modular.to.navigate(RouteName.ht.path)),
              Button.route(RouteName.c, onTap: (route == RouteName.c) ? null : () => Modular.to.navigate(RouteName.c.path)),
              const Text('menu bottom'),
              Button.route(RouteName.sair, onTap: () {
                Modular.get<AuthenticationChangeNotifier>().logout().whenComplete(() {
                  Modular.to.navigate(RouteName.l.path);
                });
              }),
              Button.route(RouteName.aj, onTap: () => showMyDialog(context, RouteName.aj)),
              Button.route(RouteName.tf, onTap: () => showMyDialog(context, RouteName.tf)),
            ]),
            Container(
              width: 200,
              height: 400,
              color: route.color,
              child: Column(children: contents),
            ),
          ],
        ),
        const Text('bottom bar'),
        Wrap(
          children: [
            Button.route(RouteName.hm, onTap: (route == RouteName.hm) ? null : () => Modular.to.navigate(RouteName.hm.path)),
            Button.route(RouteName.hp, onTap: (route == RouteName.hp) ? null : () => Modular.to.navigate(RouteName.hp.path)),
            Button.route(RouteName.tm, onTap: () => showMyDialog(context, RouteName.tm)),
            Button.route(RouteName.pl,
                onTap: (route == RouteName.pl)
                    ? null
                    : () {
                        final userId = Modular.get<AuthenticationChangeNotifier>().userLogged;
                        Modular.to.navigate(RouteName.pl.path.replaceAll(':id', userId));
                      }),
            Button.route(RouteName.c, onTap: (route == RouteName.c) ? null : () => Modular.to.navigate(RouteName.c.path)),
          ],
        ),
      ]),
    );
  }
}
