import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/viewmodels/auth_view_model.dart';
import 'package:nav2_flutter_community/viewmodels/colors_view_model.dart';
import 'package:nav2_flutter_community/widgets/color_gridview.dart';
import 'package:nav2_flutter_community/widgets/in_progress_message.dart';
import 'package:nav2_flutter_community/widgets/logout_fab.dart';
import 'package:provider/provider.dart';

// não há presença de nada de Navigator ou route, pois quem controla é o delegate
class HomeScreen extends StatelessWidget {
  HomeScreen({
    required this.onColorTap,
    required this.onLogout,
    required this.colors,
    Key? key,
  }) : super(key: key);

  final Function(String) onColorTap;
  final VoidCallback onLogout;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: _buildBody(context),
      // botão de logout
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: LogoutFab(onLogout: onLogout),
    );
  }

  Widget _buildBody(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final colorsViewModel = context.watch<ColorsViewModel>();
    bool inProgress;
    String? progressName;

    if (authViewModel.logingOut) {
      inProgress = true;
      progressName = "Logout";
    } else if (colorsViewModel.clearingColors) {
      inProgress = true;
      progressName = "Clearing colors";
    } else {
      inProgress = false;
      progressName = null;
    }

    return (inProgress && progressName != null)
        // caso o usuario deslogue diretamente do HomeScreen, ele atualiza a tela
        // e substitui por essa mensagem de estar deslogando
        ? InProgressMessage(
            progressName: progressName, screenName: "HomeScreen")
        // joga pra outra tela um método que manda qual cor foi clicada
        : ColorGrid(colors: colors, onColorTap: onColorTap);
  }
}
