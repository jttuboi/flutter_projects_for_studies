import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/route_name.dart';
import '../../widgets/button.dart';
import '../init/authentication_change_notifier.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Button.route(RouteName.l, onTap: () {
          Modular.get<AuthenticationChangeNotifier>().login().whenComplete(() {
            if (Modular.get<AuthenticationChangeNotifier>().wToAnwser) {
              Modular.to.navigate('/w');
            } else {
              Modular.to.navigate(RouteName.hm.path);
            }
          });
        }),
        Button.route(RouteName.pr, onTap: () => Modular.to.navigate(RouteName.pr.path)),
        Button.label('teste acessar pagina sem permissao pelo auth guard', onTap: () {
          Modular.to.navigate(RouteName.hm.path);
        }),
        Button.label('teste acessar pagina sem permissao pelo auth guard 2', onTap: () {
          Modular.to.navigate(RouteName.pf.path);
        }),
      ],
    ));
  }
}
