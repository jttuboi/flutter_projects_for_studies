import 'package:firebase_messaging_teste_3_3_5/pages/home_page.dart';
import 'package:firebase_messaging_teste_3_3_5/pages/notificacao_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext context)> list = <String, WidgetBuilder>{
    '/home': (_) => const HomePage(),
    '/notificacao': (_) => const NotificacaoPage(),
  };

  static const initial = '/home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
