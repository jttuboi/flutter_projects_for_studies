import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:state_management_teste/change_notifier_page.dart';
import 'package:state_management_teste/live_cells_page.dart';
import 'package:state_management_teste/live_cells_with_controller_page.dart';
import 'package:state_management_teste/set_state_page.dart';
import 'package:state_management_teste/signals_page.dart';
import 'package:state_management_teste/signals_with_controller_page.dart';
import 'package:state_management_teste/value_notifier_page.dart';

void main() {
  signalsDevToolsEnabled = false;

  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _changeNotifierController = ChangeNotifierController(0);
  final _valueNotifierController = ValueNotifier(0);
  final _signalsController = SignalsController(0);
  final _liveCellsController = LiveCellsController(0);

  @override
  void dispose() {
    _changeNotifierController.dispose();
    _valueNotifierController.dispose();
    _signalsController.dispose();
    _liveCellsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SetStatePage())),
              child: const Text('setState'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChangeNotifierPage(controller: _changeNotifierController))),
              child: const Text('ChangeNotifier'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ValueNotifierPage(controller: _valueNotifierController))),
              child: const Text('ValueNotifier'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignalsPage())),
              child: const Text('signals'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignalsWithControllerPage(controller: _signalsController))),
              child: const Text('signals with controller'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LiveCellsPage())),
              child: const Text('live cells'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => LiveCellsWithControllerPage(controller: _liveCellsController))),
              child: const Text('live cells with controller'),
            ),
          ],
        ),
      ),
    );
  }
}
