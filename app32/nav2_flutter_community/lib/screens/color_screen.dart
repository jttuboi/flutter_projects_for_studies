import 'package:flutter/services.dart';
import 'package:nav2_flutter_community/common/extensions/color_extensions.dart';
import 'package:nav2_flutter_community/common/model/shape_border_type.dart';
import 'package:nav2_flutter_community/common/widgets/app_bar_text.dart';
import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/viewmodels/auth_view_model.dart';
import 'package:nav2_flutter_community/viewmodels/colors_view_model.dart';
import 'package:nav2_flutter_community/widgets/app_bar_back_button.dart';
import 'package:nav2_flutter_community/widgets/in_progress_message.dart';
import 'package:nav2_flutter_community/widgets/logout_fab.dart';
import 'package:nav2_flutter_community/widgets/shape_border_gridview.dart';
import 'package:provider/provider.dart';

// não há presença de nada de Navigator ou route, pois quem controla é o delegate
class ColorScreen extends StatelessWidget {
  const ColorScreen({
    required this.colorCode,
    required this.onShapeTap,
    required this.onLogout,
    Key? key,
  }) : super(key: key);

  final String colorCode;
  final Function(ShapeBorderType) onShapeTap;
  final VoidCallback onLogout;

  Color get color => colorCode.hexToColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(appBarColor: color, text: '#$colorCode'),
        backgroundColor: color,
        // é o BackButton Widget. não é necessário incluir manualmente, pois
        // o AppBar já contém por default, mas foi adicionado para controle para versão web
        leading: AppBarBackButton(color: color),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: ThemeData.estimateBrightnessForColor(color),
        ),
      ),
      body: _buildBody(context),
      // botão de logout
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: LogoutFab(onLogout: onLogout, color: color),
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
    return inProgress && progressName != null
        // caso o usuario deslogue diretamente do ColorScreen, ele atualiza a tela
        // e substitui por essa mensagem de estar deslogando
        ? InProgressMessage(
            progressName: progressName, screenName: "ColorScreen")
        : ShapeBorderGridView(
            color: color,
            // joga pra outra tela um método que manda qual shape foi clicada
            onShapeTap: onShapeTap,
          );
  }
}
