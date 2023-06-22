import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Persistence3 extends StatefulWidget {
  const Persistence3({Key? key}) : super(key: key);

  @override
  _Persistence3State createState() => _Persistence3State();
}

class _Persistence3State extends State<Persistence3> {
  String _counterString = "no key";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("usando key/value"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => _add(), child: Text("increase counter")),
            ElevatedButton(
                onPressed: () => _remove(), child: Text("remove key")),
            Text("counter: $_counterString"),
          ],
        ),
      ),
    );
  }

  _add() async {
    final prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    prefs.setInt('counter', counter);
    setState(() {
      _counterString = "${prefs.getInt('counter')}";
    });
  }

  _remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('counter');
    setState(() {
      _counterString = "no key";
    });
  }
}

// https://flutter.dev/docs/cookbook/persistence/key-value
// It’s a good idea to test code that persists data using shared_preferences. 
// You can do this by mocking out the MethodChannel used by the 
// shared_preferences library.
// Populate SharedPreferences with initial values in your tests by running 
//the following code in a setupAll() method in your test files:

// const MethodChannel('plugins.flutter.io/shared_preferences')
//   .setMockMethodCallHandler((MethodCall methodCall) async {
//     if (methodCall.method == 'getAll') {
//       return <String, dynamic>{}; // set initial values here if desired
//     }
//     return null;
//   });
