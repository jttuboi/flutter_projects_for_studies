import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:live_cells/live_cells.dart';

// https://pub.dev/packages/live_cells
// https://livecell.gutev.dev/docs/intro

class LiveCellsPage extends StatefulWidget {
  const LiveCellsPage({super.key});

  @override
  State<LiveCellsPage> createState() => _LiveCellsPageState();
}

class _LiveCellsPageState extends State<LiveCellsPage> {
  late final _counter = MutableCell(0);

  @override
  Widget build(BuildContext context) {
    // ##################################################
    log('LiveCellsPage.build -> when update counter, refresh build() ONCE');
    // ##################################################
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            // ##################################################
            CellWidget.builder((context) {
              log('CellWidget.builder -> when update counter, refresh only this MANY TIMES');
              return Text('${_counter()}', style: Theme.of(context).textTheme.headlineMedium);
            }),
            // ##################################################
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _counter.value++,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
