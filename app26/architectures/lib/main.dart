import 'package:architectures/stores/app_store.dart';
import 'package:architectures/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppStore>.value(value: AppStore()),
      ],
      child: const MaterialApp(
        home: SignupView(),
      ),
    );
  }
}
