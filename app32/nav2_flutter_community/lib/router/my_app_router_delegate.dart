import 'package:nav2_flutter_community/common/model/shape_border_type.dart';
import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/router/pages/color_page.dart';
import 'package:nav2_flutter_community/router/pages/home_page.dart';
import 'package:nav2_flutter_community/router/pages/shape_page.dart';

class MyAppRouterDelegate extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  MyAppRouterDelegate();

  // key que controla as Widgets existentes
  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  // variáveis de controle para passagem de dados de uma pagina para outra
  // através de parametros
  String? _selectedColorCode;
  String? get selectedColorCode => _selectedColorCode;
  set selectedColorCode(String? value) {
    _selectedColorCode = value;
    notifyListeners();
  }

  ShapeBorderType? _selectedShapeBorderType;
  ShapeBorderType? get selectedShapeBorderType => _selectedShapeBorderType;
  set selectedShapeBorderType(ShapeBorderType? value) {
    _selectedShapeBorderType = value;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    // TODO ?? porque foi feito isso?
    final selectedShapeBorderType = this.selectedShapeBorderType;
    final selectedColorCode = this.selectedColorCode;

    return Navigator(
      key: navigatorKey,
      pages: [
        // de acordo com essa estrutura, a home page sempre irá existir
        HomePage(
          onColorTap: (String colorCode) {
            this.selectedColorCode = colorCode;
          },
        ),
        // ela adiciona por cima da home page se existir cor selecionada

        if (selectedColorCode != null)
          ColorPage(
            selectedColorCode: selectedColorCode,
            onShapeTap: (ShapeBorderType shape) {
              this.selectedShapeBorderType = shape;
            },
          ),
        // ela adiciona por cima das outras se existir cor e forma selecionada
        if (selectedColorCode != null && selectedShapeBorderType != null)
          ShapePage(
            colorCode: selectedColorCode,
            shapeBorderType: selectedShapeBorderType,
          )
      ],
      // ex:
      // - quando está na HomePage, selected color e selected shape estão null,
      //     então a lista de pages será apenas a [ HomePage ]
      // - quando está na ColorPage, selected shape está null e selected color não,
      //     então a lista de pages será [ HomePage, ColorPage ]
      // - quando está na ShapePage, selected color e selected shape não estão null,
      //     então a lista de pages será [ HomePage, ColorPage, ShapePage ]

      onPopPage: (route, result) {
        // TODO ?? como realmente funciona esse método didPop()
        // por enquanto se for true ele remonta a arvore, senão nada faz
        if (!route.didPop(result)) {
          return false;
        }

        // se estiver voltando da ColorPage apenas, pois sabe que está na
        // ColorPage por causa que selected shape é null
        // nesse caso ele limpa o selected color para que possa apenas
        // mostrar o HomePage
        if (selectedShapeBorderType == null) {
          this.selectedColorCode = null;
        }

        // se estiver voltando da ShapePage ou ColorPage,
        // ele sempre forçará a limpar, pois o selected shape apenas é <> null
        // se quiser exibir a ShapePage
        this.selectedShapeBorderType = null;

        return true;
      },
      // ex:
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {/* Do Nothing */}
}
