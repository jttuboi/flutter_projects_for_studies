import 'package:flutter/material.dart';

class App3 extends StatelessWidget {
  const App3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Router(
        routerDelegate: MyRouterDelegate(),
      ),
    );
  }
}

class MyRouterDelegate extends RouterDelegate with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> navigatorKey;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Navigator 2.0 - Animations'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
        onTap: _onNewIndexSelected,
      ),
      body: Navigator(
        key: navigatorKey,
        observers: [HeroController()], // Important to ensure that hero animations are displayed
        pages: [
          if (selectedIndex == 0)
            MyPage(
              key: ValueKey('ProfilePage'),
              child: ProfileScreen(
                onPressed: () {},
              ),
            ),
          if (selectedIndex == 1)
            MaterialPage(
              key: ValueKey('NestedNavigatorPage'),
              child: SettingScreen(),
            ),
        ],
        onPopPage: (route, result) {
          print('onPopPage NestedRouterDelegate');
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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.onPressed, Key? key}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          child: Hero(
            tag: 'redSquare',
            child: Container(height: 50, width: 50, color: Colors.redAccent),
          ),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(50.0),
            color: Colors.amberAccent,
            child: Text('Your profile'),
          ),
        ),
      ],
    );
  }
}

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          child: Hero(
            tag: 'redSquare',
            child: Container(height: 50, width: 50, color: Colors.redAccent),
          ),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(50.0),
            color: Colors.greenAccent,
            child: Text('Your settings'),
          ),
        ),
      ],
    );
  }
}

class MyPage extends Page {
  MyPage({required this.child, LocalKey? key}) : super(key: key);

  final Widget child;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
