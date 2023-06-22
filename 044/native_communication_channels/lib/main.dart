import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({BatteryService? batteryService, super.key}) : batteryService = batteryService ?? const BatteryService();

  final BatteryService batteryService;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String batteryLevelLabel = 'Battery is not started';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Method Channel'),
              const SizedBox(height: 4),
              Text(batteryLevelLabel),
              TextButton(
                onPressed: _updateBattery,
                child: const Text('Update battery'),
              ),
              const SizedBox(height: 32),
              const Text('Event Channel'),
              const SizedBox(height: 4),
              StreamBuilder(
                  stream: widget.batteryService.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(_getText(snapshot.data!.toString()));
                    }

                    return const Text('Battery is not found');
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _updateBattery() async {
    final batteryLevel = await widget.batteryService.getBatteryLevel();

    if (batteryLevel != null) {
      setState(() {
        batteryLevelLabel = _getText(batteryLevel.toString());
      });
    }
  }

  String _getText(String batteryLevel) {
    return 'Battery is $batteryLevel%';
  }
}

class BatteryService {
  const BatteryService();

  final _methodChannel = const MethodChannel('methodChannelBatteryService');
  final _eventChannel = const EventChannel('eventChannelBatteryService');

  Future<int?> getBatteryLevel() async {
    return await _methodChannel.invokeMethod<int>('getNativeBatteryLevel');
  }

  Stream get stream => _eventChannel.receiveBroadcastStream().cast();
}
