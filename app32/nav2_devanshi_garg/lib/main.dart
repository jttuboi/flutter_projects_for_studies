import 'package:flutter/material.dart';
import 'package:nav2_devanshi_garg/screens.dart';

// https://techblog.geekyants.com/navigator-20-navigation-and-routing-in-flutter

void main() => runApp(const MyApp());

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _myRouteDelegate = MyRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: MyRouteInformationParser(),
      routerDelegate: _myRouteDelegate,
    );
  }
}

enum MyRoute {
  home,
  gallery,
  seeAll,
  more,
}

class MyConfiguration {
  const MyConfiguration(this.myRoute, {required this.tab});

  final MyRoute myRoute;
  final int tab;
}

// aqui irá fazer parse da RouteInformation e irá dar a MyConfiguration para o MyRouterDelegate
class MyRouteInformationParser extends RouteInformationParser<MyConfiguration> {
  // aqui converte a RouteInformation em MyConfiguration
  @override
  Future<MyConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final String routeName = routeInformation.location ?? '';

    if (routeName == '/') {
      return MyConfiguration(MyRoute.home, tab: (routeInformation.state ?? 0) as int);
    } else if (routeName == '/gallery') {
      return MyConfiguration(MyRoute.gallery, tab: routeInformation.state as int);
    } else if (routeName == '/seeAll') {
      return MyConfiguration(MyRoute.seeAll, tab: routeInformation.state as int);
    } else if (routeName == '/seeAll/more') {
      return MyConfiguration(MyRoute.more, tab: routeInformation.state as int);
    }

    throw 'unknown';
  }

  // aqui restora a RouteInformation do MyConfiguration
  // pode retornar null, e nesse caso o browser não irá atualizar
  @override
  RouteInformation restoreRouteInformation(MyConfiguration configuration) {
    switch (configuration.myRoute) {
      case MyRoute.home:
        return RouteInformation(location: '/', state: configuration.tab);
      case MyRoute.gallery:
        return RouteInformation(location: '/gallery', state: configuration.tab);
      case MyRoute.seeAll:
        return RouteInformation(location: '/seeAll', state: configuration.tab);
      case MyRoute.more:
        return RouteInformation(location: '/seeAll/more', state: configuration.tab);
    }
  }
}

// aqui irá lidar com todas operações do sistema
// inclui converter o resultado pelo MyRouteInformationParser
class MyRouterDelegate extends RouterDelegate<MyConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyConfiguration> {
  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  MyRoute _myRoute = MyRoute.home;
  MyRoute get myRoute => _myRoute;
  set myRoute(MyRoute value) {
    if (_myRoute == value) return;
    _myRoute = value;
    notifyListeners();
  }

  int _tab = 0;
  int get tab => _tab;
  set tab(int value) {
    if (_tab == value) return;
    _tab = value;
    notifyListeners();
  }

  // aqui é chamado pelo Router quando o Router.routeInformationProvider
  // fala que a nova route foi enviada para o app pelo OS
  @override // override do RouterDelegate
  Future<void> setNewRoutePath(MyConfiguration configuration) async {
    _myRoute = configuration.myRoute;
    _tab = configuration.tab;
  }

  // para web
  // aqui é chamado pelo Router quando ele detecta a MyRouteInformation
  // poder ter mudado como um resultado da reconstrução da página
  @override
  MyConfiguration get currentConfiguration {
    return MyConfiguration(myRoute, tab: tab);
  }

  // lida com o pop() imperative na página baseada da Route
  // e de acordo com o resultado que nós pegaremos depois
  // que chamar router.didPop(), nós podemos atualizar a página
  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    final bool success = route.didPop(result);
    if (success) {
      _myRoute = MyRoute.home;
      notifyListeners();
    }
    return success;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,

      // página cria uma route que é colocado no stack de route
      // cada page pega uma key, então quando Navigator usa esta página para atualizar,
      // ele pode usar para distinguir as páginas
      pages: [
        const MaterialPage(key: ValueKey('home'), child: MyHomePage()),
        if (_myRoute == MyRoute.gallery) MaterialPage(key: const ValueKey('gallery'), child: GalleryPage(_tab)),
        if (_myRoute == MyRoute.seeAll) const MaterialPage(key: ValueKey('seeAll'), child: SeeAllPage()),
        if (_myRoute == MyRoute.more) const MaterialPage(key: ValueKey('seeAll/more'), child: ContentDetail()),
      ],

      /// This callback handles the imperative pop on the page based route (Route created by Page API) and according to the result which we will get after calling router.didPop() we can update the page.
      onPopPage: _handlePopPage,
    );
  }
}
