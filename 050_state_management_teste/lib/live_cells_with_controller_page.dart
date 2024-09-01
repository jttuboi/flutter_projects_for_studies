import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:live_cells/live_cells.dart';

// https://pub.dev/packages/live_cells
// https://livecell.gutev.dev/docs/intro

class LiveCellsWithControllerPage extends StatefulWidget {
  const LiveCellsWithControllerPage({this.controller, super.key});

  final LiveCellsController? controller;

  @override
  State<LiveCellsWithControllerPage> createState() => _LiveCellsWithControllerPageState();
}

class _LiveCellsWithControllerPageState extends State<LiveCellsWithControllerPage> {
  late final LiveCellsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? LiveCellsController(-1);
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
    log('LiveCellsWithControllerPage.build -> when update counter, refresh build() ONCE');
    // ##################################################
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            // ##################################################
            CellWidget.builder((_) {
              log('Watch.builder -> when update counter, refresh only this MANY TIMES');
              return Text('${_controller.counter()}', style: Theme.of(context).textTheme.headlineMedium);
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

class LiveCellsController {
  LiveCellsController([int initialValue = 0]) : counter = MutableCell<int>(initialValue);

  late MutableCell<int> counter;

  void incrementCounter() {
    counter.value++;
  }

  void dispose() {
    // no dispose in MutableCell or ValueCell
  }
}
