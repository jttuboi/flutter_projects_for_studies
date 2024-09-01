import 'dart:developer';

import 'package:flutter/material.dart';

class ValueNotifierPage extends StatefulWidget {
  const ValueNotifierPage({this.controller, super.key});

  final ValueNotifier<int>? controller;

  @override
  State<ValueNotifierPage> createState() => _ValueNotifierPageState();
}

class _ValueNotifierPageState extends State<ValueNotifierPage> {
  late final ValueNotifier<int> _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ValueNotifier<int>(-1);
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
    log('ValueNotifierPage.build -> when update counter, refresh build() ONCE');
    // ##################################################
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            // ##################################################
            ValueListenableBuilder(
              valueListenable: _controller,
              builder: (_, counter, __) {
                log('ValueListenableBuilder.builder -> when update counter, refresh only this MANY TIMES');
                return Text('$counter', style: Theme.of(context).textTheme.headlineMedium);
              },
            ),
            // ##################################################
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.value++,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
