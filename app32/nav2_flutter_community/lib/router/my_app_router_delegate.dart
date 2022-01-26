import 'package:nav2_flutter_community/common/model/shape_border_type.dart';
import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/data/auth_repository.dart';
import 'package:nav2_flutter_community/data/colors_repository.dart';
import 'package:nav2_flutter_community/router/pages/color_page.dart';
import 'package:nav2_flutter_community/router/pages/home_page.dart';
import 'package:nav2_flutter_community/router/pages/login_page.dart';
import 'package:nav2_flutter_community/router/pages/shape_page.dart';
import 'package:nav2_flutter_community/router/pages/splash_page.dart';

class MyAppRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  MyAppRouterDelegate(this.authRepository, this.colorsRepository) {
    _init();
  }

  final AuthRepository authRepository;
  final ColorsRepository colorsRepository;

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

  List<Color>? _colors;
  List<Color>? get colors => _colors;
  set colors(List<Color>? value) {
    _colors = value;
    notifyListeners();
  }

  bool? _loggedIn;
  bool? get loggedIn => _loggedIn;
  set loggedIn(value) {
    _loggedIn = value;
    notifyListeners();
  }

  void _init() async {
    loggedIn = await authRepository.isUserLoggedIn();
    if (loggedIn == true) {
      colors = await colorsRepository.fetchColors();
    }
  }

  // ex:
  // - quando está na HomePage, selected color e selected shape estão null,
  //     então a lista de pages será apenas a [ HomePage ]
  // - quando está na ColorPage, selected shape está null e selected color não,
  //     então a lista de pages será [ HomePage, ColorPage ]
  // - quando está na ShapePage, selected color e selected shape não estão null,
  //     então a lista de pages será [ HomePage, ColorPage, ShapePage ]
  @override
  Widget build(BuildContext context) {
    List<Page> stack;
    final loggedIn = this.loggedIn;
    // aqui existe uma estrutura melhor para selecionar as stacks a serem desenhadas
    if (loggedIn == null || (loggedIn && colors == null)) {
      stack = _splashStack;
    } else if (loggedIn && colors != null) {
      stack = _loggedInStack(colors!);
    } else {
      stack = _loggedOutStack;
    }

    return Navigator(
      key: navigatorKey,
      pages: stack,
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
    );
  }

  List<Page> get _splashStack {
    String process = "Unidentified process";

    if (loggedIn == null) {
      process = 'Checking login state...';
    } else if (colors == null) {
      process = 'Fetching colors...';
    }

    return [
      SplashPage(process: process),
    ];
  }

  List<Page> get _loggedOutStack {
    return [
      LoginPage(onLogin: () async {
        loggedIn = true;
        colors = await colorsRepository.fetchColors();
      })
    ];
  }

  List<Page> _loggedInStack(List<Color> colors) {
    final onLogout = () {
      loggedIn = false;
      _clear();
    };

    // TODO ?? porque foi feito isso?
    final selectedShapeBorderType = this.selectedShapeBorderType;
    final selectedColorCode = this.selectedColorCode;

    return [
      // de acordo com essa estrutura, a home page sempre irá existir
      HomePage(
        onColorTap: (colorCode) {
          this.selectedColorCode = colorCode;
        },
        onLogout: onLogout,
        // agora colors ele pega os dados do repository
        colors: colors,
      ),

      // ela adiciona por cima da home page se existir cor selecionada
      if (selectedColorCode != null)
        ColorPage(
          selectedColorCode: selectedColorCode,
          onShapeTap: (shapeBorderType) {
            this.selectedShapeBorderType = shapeBorderType;
          },
          onLogout: onLogout,
        ),

      // ela adiciona por cima das outras se existir cor e forma selecionada
      if (selectedColorCode != null && selectedShapeBorderType != null)
        ShapePage(
          colorCode: selectedColorCode,
          shapeBorderType: selectedShapeBorderType,
          onLogout: onLogout,
        )
    ];
  }

  _clear() {
    selectedColorCode = null;
    selectedShapeBorderType = null;
    colors = null;
  }

  @override
  Future<void> setNewRoutePath(configuration) async {/* Do Nothing */}
}
