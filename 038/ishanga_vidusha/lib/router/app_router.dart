import 'package:go_router/go_router.dart';
import 'package:go_router_training/router/route_utils.dart';
import 'package:go_router_training/services/app_service.dart';
import 'package:go_router_training/views/error_page.dart';
import 'package:go_router_training/views/home_page.dart';
import 'package:go_router_training/views/login_page.dart';
import 'package:go_router_training/views/onboarding_page.dart';
import 'package:go_router_training/views/splash_page.dart';

class AppRouter {
  AppRouter(this.appService);

  late final AppService appService;

  late final _goRouter = GoRouter(
    // o AppService é um ChangeNotifier, então toda vez que é atualizado, ele atualiza o delegate de acordo com o estado do app
    refreshListenable: appService,
    initialLocation: AppPage.home.toPath,
    routes: [
      GoRoute(
        path: AppPage.home.toPath,
        name: AppPage.home.toName,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: AppPage.splash.toPath,
        name: AppPage.splash.toName,
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: AppPage.login.toPath,
        name: AppPage.login.toName,
        builder: (_, __) => const LogInPage(),
      ),
      GoRoute(
        path: AppPage.onBoarding.toPath,
        name: AppPage.onBoarding.toName,
        builder: (_, __) => const OnBoardingPage(),
      ),
      GoRoute(
        path: AppPage.error.toPath,
        name: AppPage.error.toName,
        // essa pagina ela serve para redirecionar manualmente quando houver um erro no app
        builder: (_, state) => ErrorPage(error: state.extra.toString()),
      ),
    ],
    // aqui é para quando houver um erro relacionado a rota indefinida
    errorBuilder: (_, state) => ErrorPage(error: state.error.toString()),
    redirect: (state) {
      // aqui onde obtem os locations para saber por onde redirecionar para cada página
      final loginLocation = state.namedLocation(AppPage.login.toPath);
      final homeLocation = state.namedLocation(AppPage.home.toPath);
      final splashLocation = state.namedLocation(AppPage.splash.toPath);
      final onboardLocation = state.namedLocation(AppPage.onBoarding.toPath);

      // aqui onde obtem o estado do app
      final isLogedIn = appService.loginState;
      final isInitialized = appService.initialized;
      final isOnboarded = appService.onboarding;

      // aqui onde irá verificar se precisa redirecionar ou não
      final isGoingToLogin = state.subloc == loginLocation;
      final isGoingToInit = state.subloc == splashLocation;
      final isGoingToOnboard = state.subloc == onboardLocation;

      // o metodo de redirecionamento acontece:
      // - quando navegamos para outro local
      // - quando o AppService atualiza seu estado, ou seja, o app está logado ou não, se é splash...

      // TODO REVER

      // o app ainda não foi inicializado e não está indo para inicialização (redireciona pro splash)
      if (!isInitialized && !isGoingToInit) {
        return splashLocation;
      }
      // o app inicializou, mas não está onboarded (integrado??) e também não está indo pra onboarding (redireciona pro onbeoarding)
      else if (isInitialized && !isOnboarded && !isGoingToOnboard) {
        return onboardLocation;
      }
      // If not logedin and not going to login redirect to Login
      else if (isInitialized && isOnboarded && !isLogedIn && !isGoingToLogin) {
        return loginLocation;
      }
      // If all the scenarios are cleared but still going to any of that screen redirect to Home
      else if ((isLogedIn && isGoingToLogin) || (isInitialized && isGoingToInit) || (isOnboarded && isGoingToOnboard)) {
        return homeLocation;
      }
      // não redireciona
      else {
        return null;
      }
    },
  );

  GoRouter get router => _goRouter;
}
