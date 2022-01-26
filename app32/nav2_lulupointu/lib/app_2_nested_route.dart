import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';

class App2 extends StatelessWidget {
  const App2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Router(
        routerDelegate: AuthenticationRouterDelegate(),
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
// ROUTER DELEGATE
///////////////////////////////////////////////////////////////////////////////

class AuthenticationRouterDelegate extends RouterDelegate with ChangeNotifier {
  AuthenticationRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> navigatorKey;

  bool isAuthenticated = false;

  @override
  Future<bool> popRoute() async {
    print('AuthenticationRouterDelegate.popRoute');
    MoveToBackground.moveTaskToBack();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      observers: [
        HeroController(),
      ],
      pages: [
        MaterialPage(
          key: ValueKey('MyAuthenticationScreen'),
          child: AuthenticationScreen(
            onPressed: () {
              isAuthenticated = true;
              notifyListeners();
            },
          ),
        ),
        if (isAuthenticated)
          MaterialPage(
            key: ValueKey('NestedRouterScreen'),
            child: HomeScreen(),
          ),
      ],
      onPopPage: (route, result) {
        print('AuthenticationRouterDelegate.onPopPage');
        if (!route.didPop(result)) return false;

        isAuthenticated = false;
        notifyListeners();
        return true;
      },
    );
  }

  // We don't use named navigation so we don't use this
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}

final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();

class HomeRouterDelegate extends RouterDelegate with ChangeNotifier {
  HomeRouterDelegate();

  int selectedIndex = 0;

  @override
  Future<bool> popRoute() async {
    print('HomeRouterDelegate.popRoute');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('You are connected')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
        onTap: _onNewIndexSelected,
      ),
      body: Navigator(
        key: _homeNavigatorKey,
        observers: [HeroController()],
        pages: [
          if (selectedIndex == 0)
            MaterialPage(
              key: ValueKey('ProfileTab'),
              child: ProfileTab(
                onPressed: () {},
              ),
            ),
          if (selectedIndex == 1)
            MaterialPage(
              key: ValueKey('SettingsTab'),
              child: SettingsTab(),
            ),
        ],
        onPopPage: (route, result) {
          print('HomeRouterDelegate.onPopPage');
          return false;
        },
      ),
    );
  }

  // We don't use named navigation so we don't use this
  @override
  Future<void> setNewRoutePath(configuration) async => null;

  void _onNewIndexSelected(int value) {
    selectedIndex = value;
    notifyListeners();
  }
}

///////////////////////////////////////////////////////////////////////////////
// SCREENS
///////////////////////////////////////////////////////////////////////////////

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({required this.onPressed, Key? key}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('You are connected')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: onPressed,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.greenAccent,
                child: Text('Click me to connect.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final childBackButtonDispatcher = ChildBackButtonDispatcher(Router.of(context).backButtonDispatcher!);
    childBackButtonDispatcher.takePriority();

    return Router(
      routerDelegate: HomeRouterDelegate(),
      backButtonDispatcher: childBackButtonDispatcher,
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({required this.onPressed, Key? key}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Your profile'),
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Your settings'),
          TextButton(
            child: Container(color: Colors.redAccent, child: Icon(Icons.arrow_back_ios)),
            onPressed: () {
              // esse pop() chama o HomeRouterDelegate.onPopPage, pois o context
              // é em relação ao HomeRouterDelegate
              return Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
