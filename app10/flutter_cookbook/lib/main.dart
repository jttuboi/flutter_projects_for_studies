import 'package:flutter/material.dart';
import 'package:flutter_cookbook/animation_1.dart';
import 'package:flutter_cookbook/animation_2.dart';
import 'package:flutter_cookbook/animation_3.dart';
import 'package:flutter_cookbook/animation_4.dart';
import 'package:flutter_cookbook/design_1.dart';
import 'package:flutter_cookbook/design_2.dart';
import 'package:flutter_cookbook/design_3.dart';
import 'package:flutter_cookbook/design_4.dart';
import 'package:flutter_cookbook/design_5.dart';
import 'package:flutter_cookbook/design_6.dart';
import 'package:flutter_cookbook/effect_1.dart';
import 'package:flutter_cookbook/effect_2.dart';
import 'package:flutter_cookbook/effect_3.dart';
import 'package:flutter_cookbook/effect_4.dart';

class Routes {
  static const String home = "/";
  static const String animation_1 = "/animation_1";
  static const String animation_2 = "/animation_2";
  static const String animation_3 = "/animation_3";
  static const String animation_4 = "/animation_4";
  static const String design_1 = "/design_1";
  static const String design_2 = "/design_2";
  static const String design_3 = "/design_3";
  static const String design_4 = "/design_4";
  static const String design_5 = "/design_5";
  static const String design_6 = "/design_6";
  static const String effect_1 = "/effect_1";
  static const String effect_2 = "/effect_2";
  static const String effect_3 = "/effect_3";
  static const String effect_4 = "/effect_4";
}

void main() => runApp(
      MaterialApp(
        routes: {
          Routes.home: (context) => Home(),
          Routes.animation_1: (context) => Animation1(),
          Routes.animation_2: (context) => Animation2(),
          Routes.animation_3: (context) => Animation3(),
          Routes.animation_4: (context) => Animation4(),
          Routes.design_1: (context) => Design1(),
          Routes.design_2: (context) => Design2(),
          Routes.design_3: (context) => Design3(),
          Routes.design_4: (context) => Design4(),
          Routes.design_5: (context) => Design5(),
          Routes.design_6: (context) => Design6(),
          Routes.effect_1: (context) => Effect1(),
          Routes.effect_2: (context) => Effect2(),
          Routes.effect_3: (context) => Effect3(),
          Routes.effect_4: (context) => Effect4(),
        },
        debugShowCheckedModeBanner: false,
        // design 5
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
          fontFamily: "Georgia",
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 16.0, fontFamily: "Hind"),
          ),
        ),
        // effect 2
        onGenerateRoute: (settings) {
          late Widget page;

          if (settings.name == Effect2Routes.home) {
            page = Effect2();
          } else if (settings.name == Effect2Routes.settings) {
            page = Effect2Settings();
          } else if (settings.name!
              .startsWith(Effect2Routes.prefixDeviceSetup)) {
            final subRoute = settings.name!
                .substring(Effect2Routes.prefixDeviceSetup.length);
            page = Effect2SetupFlow(setupPageRoute: subRoute);
          } else {
            throw Exception('Unknown route: ${settings.name}');
          }
          return MaterialPageRoute<dynamic>(
            builder: (context) {
              return page;
            },
            settings: settings,
          );
        },
      ),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Detail> _details;

  @override
  void initState() {
    _details = [
      // é testado animações diferenciadas para mudanças de tela.
      // obs: as animações funcionam com qualquer widget que aceite animações.
      // https://flutter.dev/docs/cookbook/animation/page-route-animation.html
      Detail(title: "animation - change screen", route: Routes.animation_1),

      // é testado animações arrastar e soltar em um widget com imagem.
      // o efeito da animação utilizada é mais complexa, usando controller
      // e SpringSimulation.
      // https://flutter.dev/docs/cookbook/animation/physics-simulation.html
      Detail(
          title: "animation - drag/drop container", route: Routes.animation_2),

      // é testado animações do container.
      // tem o widget AnimationContainer e é mostrado parte de seu uso
      // voltado para animação, já que a outra parte é o container em si
      // https://flutter.dev/docs/cookbook/animation/animated-container.html
      Detail(
          title: "animation - animation container", route: Routes.animation_3),

      // é testado animação de aparecer e desaparecer com widget AnimatedOpacity.
      // https://flutter.dev/docs/cookbook/animation/opacity-animation.html
      Detail(
          title: "animation - animation fade in/out",
          route: Routes.animation_4),

      // uso do Drawer.
      // https://flutter.dev/docs/cookbook/design/drawer.html
      Detail(title: "design - drawer", route: Routes.design_1),

      // uso do SnackBar.
      // como se fosse a notificação, porém dentro do app e é mostrado na parte inferior
      // https://flutter.dev/docs/cookbook/design/snackbars.html
      Detail(title: "design - snackbar", route: Routes.design_2),

      // uso de fonts diferenciadas.
      // tem a forma padrão via projeto e a forma via google_fonts
      // https://pub.dev/packages/google_fonts
      // https://flutter.dev/docs/cookbook/design/fonts.html
      // https://flutter.dev/docs/cookbook/design/package-fonts.html (this is not made it)
      Detail(title: "design - fonts", route: Routes.design_3),

      // uso de orientação
      // para celular, tem que girar o celular
      // para desktop e web, tem que mudar o tamanho da tela
      // https://flutter.dev/docs/cookbook/design/orientation.html
      Detail(title: "design - orientation", route: Routes.design_4),

      // uso de themes
      // olhar no topo que tem o theme default descrito no MaterialApp
      // https://flutter.dev/docs/cookbook/design/themes
      Detail(title: "design - theme", route: Routes.design_5),

      // uso de tabs
      // https://flutter.dev/docs/cookbook/design/tabs
      Detail(title: "design - tabs", route: Routes.design_6),

      // download effect
      // https://flutter.dev/docs/cookbook/effects/download-button
      Detail(title: "effect - download", route: Routes.effect_1),

      // controle de fluxo
      // um controle alternativo das routes, onde pode concentrar o controle
      // do fluxo.
      // https://flutter.dev/docs/cookbook/effects/nested-nav
      Detail(title: "effect - nested navigation flow", route: Routes.effect_2),

      // adiciona filtro nas fotos utilizando scroll dos filtros
      // utiliza o PageView para fazer o efeito do carousel, onde troca a
      // cor dos filtros pra foto
      // https://flutter.dev/docs/cookbook/effects/photo-filter-carousel
      Detail(title: "effect - photo filter carousel", route: Routes.effect_3),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _details.length,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () =>
                Navigator.pushNamed(context, _details[index].route),
            child: Text(_details[index].title),
          );
        },
      ),
    );
  }
}

class Detail {
  String title;
  String route;

  Detail({required this.title, required this.route});
}
