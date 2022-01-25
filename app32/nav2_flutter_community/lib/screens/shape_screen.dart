import 'package:nav2_flutter_community/common/extensions/color_extensions.dart';
import 'package:nav2_flutter_community/common/model/shape_border_type.dart';
import 'package:nav2_flutter_community/common/widgets/app_bar_text.dart';
import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/widgets/app_bar_back_button.dart';
import 'package:nav2_flutter_community/widgets/shaped_button.dart';

// não há presença de nada de Navigator ou route, pois quem controla é o delegate
class ShapeScreen extends StatelessWidget {
  const ShapeScreen({required this.colorCode, required this.shapeBorderType, Key? key}) : super(key: key);

  final String colorCode;
  final ShapeBorderType shapeBorderType;

  Color get color => colorCode.hexToColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppBarText(
            appBarColor: color,
            text: '${shapeBorderType.stringRepresentation().toUpperCase()} #$colorCode ',
          ),
          // é o BackButton Widget. não é necessário incluir manualmente, pois
          // o AppBar já contém por default, mas foi adicionado para controle para versão web
          leading: AppBarBackButton(color: color),
          backgroundColor: color,
        ),
        body: Center(
          child: ShapedButton(
            color: color,
            shapeBorderType: shapeBorderType,
          ),
        ));
  }
}
