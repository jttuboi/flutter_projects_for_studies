import 'package:counter/counter/view/counter_page.dart';
import 'package:flutter/material.dart';

// na maioria dos casos é utilizado StatelessWidget ou StatefulWidget
// com MaterialApp dentro, porém como CounterApp é um MaterialApp
// sem mais nenhum Widget, foi utilizado extends diretamente.
class CounterApp extends MaterialApp {
  const CounterApp({Key? key})
      : super(
          key: key,
          home: const CounterPage(),
        );
}
