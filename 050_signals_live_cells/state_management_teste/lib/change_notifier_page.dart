import 'dart:developer';

import 'package:flutter/material.dart';

class ChangeNotifierPage extends StatefulWidget {
  const ChangeNotifierPage({this.controller, super.key});

  final ChangeNotifierController? controller;

  @override
  State<ChangeNotifierPage> createState() => _ChangeNotifierPageState();
}

class _ChangeNotifierPageState extends State<ChangeNotifierPage> {
  late final ChangeNotifierController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ChangeNotifierController(-1);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ##################################################
    log('ChangeNotifierPage.build -> when update counter, refresh build() ONCE');
    // ##################################################
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            // ##################################################
            ListenableBuilder(
              listenable: _controller,
              builder: (_, child) {
                log('ListenableBuilder.builder -> when update counter, refresh only this MANY TIMES');
                return Text('${_controller.counter}', style: Theme.of(context).textTheme.headlineMedium);
              },
            ),
            // ##################################################
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.incrementCounter(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ChangeNotifierController extends ChangeNotifier {
  ChangeNotifierController([this._counter = 0]);

  int _counter;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}
