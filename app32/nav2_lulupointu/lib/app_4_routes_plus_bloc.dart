import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App4 extends StatelessWidget {
  const App4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(),
      child: MaterialApp(
        home: Router(
          routerDelegate: MyRouterDelegate(),
        ),
      ),
    );
  }
}

class MyRouterDelegate extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> navigatorKey;

  bool showOtherPage = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authenticationState) {
        return Navigator(
          key: navigatorKey,
          pages: [
            MaterialPage(
              key: ValueKey('MyConnectionPage'),
              child: MyConnexionWidget(),
            ),
            if (authenticationState is AuthenticatedState)
              MaterialPage(
                key: ValueKey('MyHomePage'),
                child: MyHomeWidget(),
              ),
          ],
          onPopPage: (route, result) {
            if (!route.didPop(result)) return false;

            BlocProvider.of<AuthenticationBloc>(context).add(UserLogoutEvent());
            return true;
          },
        );
      },
    );
  }

  // We don't use named navigation so we don't use this
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}

class MyConnexionWidget extends StatelessWidget {
  const MyConnexionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Navigator 2.0 101 - Connexion screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.greenAccent,
                child: Text('Click me to connect.'),
              ),
              onPressed: () => BlocProvider.of<AuthenticationBloc>(context).add(UserLoginEvent()),
            )
          ],
        ),
      ),
    );
  }
}

class MyHomeWidget extends StatelessWidget {
  const MyHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Navigator 2.0 101 - Home screen')),
      body: Center(
        child: Text('You are connected!'),
      ),
    );
  }
}

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(UnauthenticatedState()) {
    on<UserLoginEvent>(_onUserLoginEvent);
    on<UserLogoutEvent>(_onUserLogoutEvent);
  }

  Future<void> _onUserLoginEvent(UserLoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticatedState());
  }

  Future<void> _onUserLogoutEvent(UserLogoutEvent event, Emitter<AuthenticationState> emit) async {
    emit(UnauthenticatedState());
  }
}

// Authentication events
abstract class AuthenticationEvent {}

class UserLogoutEvent extends AuthenticationEvent {}

class UserLoginEvent extends AuthenticationEvent {}

// Authentication states
abstract class AuthenticationState {}

class UnauthenticatedState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {}
