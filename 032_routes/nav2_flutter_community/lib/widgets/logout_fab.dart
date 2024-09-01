import 'package:nav2_flutter_community/common/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/viewmodels/auth_view_model.dart';
import 'package:nav2_flutter_community/viewmodels/colors_view_model.dart';
import 'package:provider/provider.dart';

class LogoutFab extends StatelessWidget {
  const LogoutFab({
    required this.onLogout,
    this.color = Colors.white,
    Key? key,
  }) : super(key: key);

  final VoidCallback onLogout;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final colorsViewModel = context.watch<ColorsViewModel>();
    return authViewModel.logingOut || colorsViewModel.clearingColors
        ? _inProgressFab()
        : _extendedFab(authViewModel, colorsViewModel);
  }

  // cria um fab loading
  Widget _inProgressFab() {
    final color = this.color;
    return FloatingActionButton(
      onPressed: null,
      child: CircularProgressIndicator(backgroundColor: Colors.white),
      foregroundColor: color.onTextColor(),
      backgroundColor: color,
    );
  }

  // cria uma fab de logout
  Widget _extendedFab(
    AuthViewModel authViewModel,
    ColorsViewModel colorsViewModel,
  ) {
    final color = this.color;
    return FloatingActionButton.extended(
      icon: Icon(Icons.exit_to_app),
      onPressed: () async {
        await authViewModel.logout();
        colorsViewModel.clearColors();
        onLogout();
      },
      foregroundColor: color.onTextColor(),
      backgroundColor: color,
      label: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Logout'),
      ),
    );
  }
}
