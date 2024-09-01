import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../widgets/button.dart';
import '../init/authentication_change_notifier.dart';

class WEndScreen extends StatelessWidget {
  const WEndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('w end')),
      body: Button.label('home', onTap: () {
        Modular.get<AuthenticationChangeNotifier>().wFinished().whenComplete(() => Modular.to.navigate('/hm'));
      }),
    );
  }
}
