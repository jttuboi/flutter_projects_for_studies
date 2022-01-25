import 'package:nav2_flutter_community/common/extensions/color_extensions.dart';
import 'package:nav2_flutter_community/common/model/shape_border_type.dart';
import 'package:nav2_flutter_community/common/widgets/app_bar_text.dart';
import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/widgets/app_bar_back_button.dart';
import 'package:nav2_flutter_community/widgets/shape_border_gridview.dart';

// não há presença de nada de Navigator ou route, pois quem controla é o delegate
class ColorScreen extends StatelessWidget {
  const ColorScreen({required this.colorCode, required this.onShapeTap, Key? key}) : super(key: key);

  final String colorCode;
  final Function(ShapeBorderType) onShapeTap;

  Color get color => colorCode.hexToColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(appBarColor: color, text: '#$colorCode'),
        backgroundColor: colorCode.hexToColor(),
        // é o BackButton Widget. não é necessário incluir manualmente, pois
        // o AppBar já contém por default, mas foi adicionado para controle para versão web
        leading: AppBarBackButton(color: color),
      ),
      body: ShapeBorderGridView(
        color: color,
        // joga pra outra tela um método que manda qual shape foi clicada
        onShapeTap: onShapeTap,
      ),
    );
  }
}
