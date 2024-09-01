import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

// https://pub.dev/packages/signals

class SignalsWithControllerPage extends StatefulWidget {
  const SignalsWithControllerPage({this.controller, super.key});

  final SignalsController? controller;

  @override
  State<SignalsWithControllerPage> createState() => _SignalsWithControllerPageState();
}

class _SignalsWithControllerPageState extends State<SignalsWithControllerPage> with SignalsMixin {
  late final SignalsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? SignalsController(-1);
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
    log('SignalsWithControllerPage.build -> when update counter, refresh build() ONCE');
    // ##################################################
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            // ##################################################
            Watch.builder(builder: (_) {
              log('Watch.builder -> when update counter, refresh only this MANY TIMES');
              return Text('${_controller.counter}', style: Theme.of(context).textTheme.headlineMedium);
            }),
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

class SignalsController {
  SignalsController([int initialValue = 0]) : counter = Signal<int>(initialValue);

  late Signal<int> counter;

  void incrementCounter() {
    counter.value++;
  }

  void dispose() {
    counter.dispose();
  }
}
