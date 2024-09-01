import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raywenderlich/constants.dart';
import 'package:raywenderlich/login_state.dart';
import 'package:raywenderlich/ui/error_page.dart';
import 'package:raywenderlich/ui/home_screen.dart';
import 'package:raywenderlich/ui/login/create_account.dart';
import 'package:raywenderlich/ui/login/login.dart';
import 'package:raywenderlich/ui/profile/more_info.dart';
import 'package:raywenderlich/ui/profile/payment.dart';
import 'package:raywenderlich/ui/profile/personal_info.dart';
import 'package:raywenderlich/ui/profile/signin_info.dart';
import 'package:raywenderlich/ui/shop/details.dart';

class MyRouter {
  MyRouter(this.loginState);

  final LoginState loginState;

  late final router = GoRouter(
    // login state é onde controla se o usuario está logado ou nao
    // então o go_outer atualiza o delegate de acordo com o notifier desta classe
    refreshListenable: loginState,
    debugLogDiagnostics: true,
    // url strategy é mais para web, onde utiliza / (path) ou # (hash) no final da url
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        name: rootRouteName,
        path: '/',
        redirect: (state) => state.namedLocation(homeRouteName, params: {'tab': 'shop'}),
      ),
      GoRoute(
        name: loginRouteName,
        path: '/login',
        pageBuilder: (context, state) => MaterialPage<void>(key: state.pageKey, child: const Login()),
      ),
      GoRoute(
        name: createAccountRouteName,
        path: '/create-account',
        pageBuilder: (context, state) => MaterialPage<void>(key: state.pageKey, child: const CreateAccount()),
      ),
      GoRoute(
        name: homeRouteName,
        // aqui exige que tenha uma tab (senão dará erro de null)
        // tab é o nome da constante do params
        // shop|cart|profile são os possíveis dados aceitos
        path: '/home/:tab(shop|cart|profile)',
        pageBuilder: (_, state) => MaterialPage<void>(key: state.pageKey, child: HomeScreen(tab: state.params['tab']!)),
        // essas são as rotas que podem ser acessadas a partir do home
        routes: [
          // este é acessado pelo shop
          GoRoute(
            name: subDetailsRouteName,
            // aqui exige que tenha um item (senão dará erro de null)
            path: 'details/:item',
            pageBuilder: (_, state) => MaterialPage<void>(key: state.pageKey, child: Details(description: state.params['item']!)),
          ),
          // os abaixo pertence ao profile
          GoRoute(
            name: profilePersonalRouteName,
            path: 'personal',
            pageBuilder: (_, state) => MaterialPage<void>(key: state.pageKey, child: const PersonalInfo()),
          ),
          GoRoute(
            name: profilePaymentRouteName,
            path: 'payment',
            pageBuilder: (_, state) => MaterialPage<void>(key: state.pageKey, child: const Payment()),
          ),
          GoRoute(
            name: profileSigninInfoRouteName,
            path: 'signin-info',
            pageBuilder: (_, state) => MaterialPage<void>(key: state.pageKey, child: const SigninInfo()),
          ),
          GoRoute(
            name: profileMoreInfoRouteName,
            path: 'more-info',
            pageBuilder: (_, state) => MaterialPage<void>(key: state.pageKey, child: const MoreInfo()),
          ),
        ],
      ),
      // não estão nomeados pq no home_screen está sendo mostrado como funciona o go() utilizando path.
      GoRoute(
        path: '/shop',
        redirect: (state) => state.namedLocation(homeRouteName, params: {'tab': 'shop'}),
      ),
      GoRoute(
        path: '/cart',
        redirect: (state) => state.namedLocation(homeRouteName, params: {'tab': 'cart'}),
      ),
      GoRoute(
        path: '/profile',
        redirect: (state) => state.namedLocation(homeRouteName, params: {'tab': 'profile'}),
      ),
      // serverm para redirecionar as "paginas de detalhes" (algo como os pushs, q constrôem a pilha)
      GoRoute(
        name: detailsRouteName,
        path: '/details-redirector/:item',
        redirect: (state) => state.namedLocation(subDetailsRouteName, params: {'tab': 'shop', 'item': state.params['item']!}),
      ),
      GoRoute(
        name: personalRouteName,
        path: '/profile-personal',
        redirect: (state) => state.namedLocation(profilePersonalRouteName, params: {'tab': 'profile'}),
      ),
      GoRoute(
        name: paymentRouteName,
        path: '/profile-payment',
        redirect: (state) => state.namedLocation(profilePaymentRouteName, params: {'tab': 'profile'}),
      ),
      GoRoute(
        name: signinInfoRouteName,
        path: '/profile-signin-info',
        redirect: (state) => state.namedLocation(profileSigninInfoRouteName, params: {'tab': 'profile'}),
      ),
      GoRoute(
        name: moreInfoRouteName,
        path: '/profile-more-info',
        redirect: (state) => state.namedLocation(profileMoreInfoRouteName, params: {'tab': 'profile'}),
      ),
    ],
    // esta página mostra o erro lançado pelo go router
    errorPageBuilder: (_, state) => MaterialPage<void>(key: state.pageKey, child: ErrorPage(error: state.error)),
    redirect: (state) {
      log('---- redirect(${state.location})');
      //// exemplo para deixar claro o funcionamento
      //// state.subloc = 'create-account'

      final loginLoc = state.namedLocation(loginRouteName);
      final loggingIn = state.subloc == loginLoc;
      final createAccountLoc = state.namedLocation(createAccountRouteName);
      final creatingAccount = state.subloc == createAccountLoc;
      final rootLoc = state.namedLocation(rootRouteName);
      final loggedIn = loginState.loggedIn;

      log('* loggingIn: $loggingIn, creatingAccount: $creatingAccount, loggedIn: $loggedIn) - ${state.location} ${state.subloc} ${state.name} ${state.fullpath} ${state.path}');

      //// no primeiro if ele não entra
      //// no segundo, ele só entra caso esteja logado,
      ////   então nesse caso ele redireciona para home, pois se ele está logado, ele não deve ter acesso a pagina do create

      // essa parte redireciona caso a pagina a ser acessada não tem permissão ou algo similar
      if (!loggedIn && !loggingIn && !creatingAccount) {
        log('- redirecting to $loginLoc 1');
        return loginLoc;
      }
      if (loggedIn && (loggingIn || creatingAccount)) {
        log('- redirecting to $rootLoc 2');
        return rootLoc;
      }

      //// caso ele não seja redirecionado, então o go router chama a classe CreateAccount()

      // caso não caia em nenhuma das situações, então deixa prosseguir para a página que deve ir
      log('- redirecting to ${state.location}++');
      return null;
    },
  );
}
