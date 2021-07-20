import 'package:flutter/material.dart';
import 'package:semana_do_flutter_arquitetura/app/pages/app_controller.dart';

class CustomSwitchWidget extends StatelessWidget {
  const CustomSwitchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: AppController.instance.isDark,
      onChanged: (value) => AppController.instance.changeTheme(value),
    );
  }
}
