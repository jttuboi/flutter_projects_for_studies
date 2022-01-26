import 'package:nav2_flutter_community/common/extensions/color_extensions.dart';
import 'package:nav2_flutter_community/common/model/shape_border_type.dart';
import 'package:nav2_flutter_community/common/widgets/app_bar_text.dart';
import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/viewmodels/auth_view_model.dart';
import 'package:nav2_flutter_community/viewmodels/colors_view_model.dart';
import 'package:nav2_flutter_community/widgets/app_bar_back_button.dart';
import 'package:nav2_flutter_community/widgets/in_progress_message.dart';
import 'package:nav2_flutter_community/widgets/logout_fab.dart';
import 'package:nav2_flutter_community/widgets/shaped_button.dart';
import 'package:provider/provider.dart';

// não há presença de nada de Navigator ou route, pois quem controla é o delegate
class ShapeScreen extends StatelessWidget {
  const ShapeScreen({
    required this.colorCode,
    required this.shapeBorderType,
    required this.onLogout,
    Key? key,
  }) : super(key: key);

  final String colorCode;
  final ShapeBorderType shapeBorderType;
  final VoidCallback onLogout;

  Color get color => colorCode.hexToColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(
          appBarColor: color,
          text:
              '${shapeBorderType.stringRepresentation().toUpperCase()} #$colorCode ',
        ),
        // é o BackButton Widget. não é necessário incluir manualmente, pois
        // o AppBar já contém por default, mas foi adicionado para controle para versão web
        leading: AppBarBackButton(color: color),
        backgroundColor: color,
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
        // caso o usuario deslogue diretamente do ShapeScreen, ele atualiza a tela
        // e substitui por essa mensagem de estar deslogando
        // TODO ?? isso é válido? Todas páginas teriam que ter isso? Talvez a melhor solução seria
        // reconstruir a Navigator para mostrar só o LoginScreen (nesse exemplo)
        ? InProgressMessage(
            progressName: progressName, screenName: "ShapeScreen")
        // senao ele continua mostrando o conteúdo da página
        : Center(
            child: ShapedButton(
              color: color,
              // joga pra outra tela um método que manda qual shape foi clicada
              shapeBorderType: shapeBorderType,
            ),
          );
  }
}
