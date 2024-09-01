import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/route_name.dart';
import '../../widgets/button.dart';

class PRScreen extends StatelessWidget {
  const PRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Modular.to.navigate(RouteName.l.path);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(RouteName.pr.name)),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button.label('back', onTap: () => Modular.to.navigate(RouteName.l.path)),
          ],
        )),
      ),
    );
  }
}
