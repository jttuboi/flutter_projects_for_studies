import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/home/c_screen.dart';
import 'features/home/fp_screen.dart';
import 'features/home/hp_screen.dart';
import 'features/home/hpd_screen.dart';
import 'features/home/ht_screen.dart';
import 'features/home/pf_cubit.dart';
import 'features/home/pf_screen.dart';
import 'features/home/pl_cubit.dart';
import 'features/home/pl_screen.dart';
import 'features/home/screen_with_menu.dart';
import 'features/init/authentication_change_notifier.dart';
import 'features/login/login_screen.dart';
import 'features/login/pr_screen.dart';
import 'features/w/w_end_screen.dart';
import 'features/w/w_screen.dart';
import 'services/http_client_service.dart';
import 'services/key_value_database_service.dart';
import 'utils/my_observer.dart';
import 'utils/route_name.dart';

void main() {
  Modular
    ..setInitialRoute(RouteName.l.path)
    ..setObservers([MyObserver()]);

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<AuthenticationChangeNotifier>((i) => AuthenticationChangeNotifier(), onDispose: (changeNotifier) => changeNotifier.dispose()),
        Bind.singleton<IHttpClientService>((i) => DioService(), onDispose: (service) => service.close()),
        Bind.singleton<IKeyValueDatabaseService>((i) => const SharedPreferencesService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(RouteName.l.path, child: (_, __) => const LoginScreen()),
        ChildRoute(RouteName.pr.path, child: (_, __) => const PRScreen()),
        ModuleRoute('/w', module: WModule(), guards: [WGuard()]),
        ModuleRoute('/', module: HomeModule(), guards: [HomeGuard()]),
      ];
}

class WGuard extends RouteGuard {
  WGuard() : super(redirectTo: '/l');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    print('WGuard.canActivate($path, $route)');
    final wToAnwser = Modular.get<AuthenticationChangeNotifier>().wToAnwser;
    print('WGuard.wToAnwser = $wToAnwser');
    return wToAnwser;
  }
}

class HomeGuard extends RouteGuard {
  HomeGuard() : super(redirectTo: '/l');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    print('HomeGuard.canActivate($path, $route)');
    final isLogged = Modular.get<AuthenticationChangeNotifier>().isLogged;
    print('HomeGuard.isLogged = $isLogged');
    return isLogged;
  }
}

class WModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute('/', child: (_, __) => const WScreen()),
      ChildRoute('/end', child: (_, __) => const WEndScreen()),
    ];
  }
}

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<PfCubit>((i) => PfCubit()),
        Bind.factory<PlCubit>((i) => PlCubit()),
      ];

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(RouteName.hm.path, child: (_, __) => const ScreenWithMenu(RouteName.hm)),
      ChildRoute(RouteName.pf.path, child: (_, __) => PfScreen()),
      ChildRoute(RouteName.pl.path, child: (_, args) => PlScreen(userId: args.params['id'])),
      ChildRoute(RouteName.sd.path, child: (_, __) => const ScreenWithMenu(RouteName.sd)),
      ChildRoute(RouteName.hp.path, child: (_, __) => const HpScreen()),
      ChildRoute(RouteName.hpd.path, child: (_, args) => HpDScreen(id: args.params['id'])),
      ChildRoute(RouteName.f.path, child: (_, __) => const ScreenWithMenu(RouteName.f)),
      ChildRoute(RouteName.ht.path, child: (_, __) => const HtScreen()),
      ModuleRoute(RouteName.c.path, module: SettingsModule()),
    ];
  }
}

class SettingsModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const CScreen()),
        ChildRoute(RouteName.ip.path, child: (_, __) => const ScreenWithMenu(RouteName.ip)),
        ChildRoute(RouteName.s.path, child: (_, __) => const ScreenWithMenu(RouteName.s)),
        ChildRoute(RouteName.f.path, child: (_, __) => const ScreenWithMenu(RouteName.f)),
        ChildRoute(RouteName.fp.path, child: (_, __) => const FpScreen()),
        ChildRoute(RouteName.cfp.path, child: (_, __) => const ScreenWithMenu(RouteName.cfp)),
        ChildRoute(RouteName.tp.path, child: (_, __) => const ScreenWithMenu(RouteName.tp)),
      ];
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('AppWidget.build()');
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
    // return AnimatedBuilder(
    //     animation: Modular.get<AuthenticationChangeNotifier>(),
    //     builder: (_, __) {
    //       print('AnimatedBuilder.builder()');
    //       return MaterialApp.router(
    //         title: 'Flutter Demo',
    //         theme: ThemeData(
    //           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //           useMaterial3: true,
    //         ),
    //         routeInformationParser: Modular.routeInformationParser,
    //         routerDelegate: Modular.routerDelegate,
    //       );
    //     });
  }
}
