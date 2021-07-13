import 'package:flutter/material.dart';

class Effect2Routes {
  static const String home = '/effect_2';
  static const String settings = '/settings';
  static const String prefixDeviceSetup = '/setup/';
  static const String deviceSetupStart = '/setup/$deviceSetupStartPage';
  static const String deviceSetupStartPage = 'find_devices';
  static const String deviceSetupSelectDevicePage = 'select_device';
  static const String deviceSetupConnectingPage = 'connecting';
  static const String deviceSetupFinishedPage = 'finished';
}

class Effect2 extends StatelessWidget {
  const Effect2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF222222),
                ),
                child: Center(
                  child: Icon(
                    Icons.lightbulb,
                    size: 175,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Add your first bulb',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Effect2Routes.deviceSetupStart);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Welcome'),
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, Effect2Routes.settings);
          },
        ),
      ],
    );
  }
}

class Effect2SetupFlow extends StatefulWidget {
  const Effect2SetupFlow({
    Key? key,
    required this.setupPageRoute,
  }) : super(key: key);

  final String setupPageRoute;

  @override
  _Effect2SetupFlowState createState() => _Effect2SetupFlowState();
}

class _Effect2SetupFlowState extends State<Effect2SetupFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExitDesired,
      child: Scaffold(
        appBar: _buildFlowAppBar(),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.setupPageRoute,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildFlowAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: _onExitPressed,
        icon: Icon(Icons.chevron_left),
      ),
      title: Text("bulb setup"),
    );
  }

  Future<bool> _isExitDesired() async {
    return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Are you sure?"),
              content:
                  Text("if you exit device setup, your progress will be lost."),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("leave")),
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text("stay")),
              ],
            );
          },
        ) ??
        false;
    // if showDialog() return null, then _isExitDesired() always return false
    // otherwise showDialog() return value
  }

  Future<void> _onExitPressed() async {
    final isConfirmed = await _isExitDesired();
    if (isConfirmed && mounted) {
      Navigator.pop(context); // exit setup
    }
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case Effect2Routes.deviceSetupStartPage:
        page = WaitingPage(
          message: "searching for nearby bulb...",
          onWaitComplete: _onDiscoveryComplete,
        );
        break;
      case Effect2Routes.deviceSetupSelectDevicePage:
        page = SelectDevicePage(
          onDeviceSelected: _onDeviceSelected,
        );
        break;
      case Effect2Routes.deviceSetupConnectingPage:
        page = WaitingPage(
          message: 'Connecting...',
          onWaitComplete: _onConnectionEstablished,
        );
        break;
      case Effect2Routes.deviceSetupFinishedPage:
        page = FinishedPage(
          onFinishPressed: () => Navigator.pop(context), // exit setup,
        );
        break;
    }

    return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return page;
        });
  }

  void _onDiscoveryComplete() {
    _navigatorKey.currentState!.pushNamed(
      Effect2Routes.deviceSetupSelectDevicePage,
    );
  }

  void _onDeviceSelected(String deviceId) {
    _navigatorKey.currentState!.pushNamed(
      Effect2Routes.deviceSetupConnectingPage,
    );
  }

  void _onConnectionEstablished() {
    _navigatorKey.currentState!.pushNamed(
      Effect2Routes.deviceSetupFinishedPage,
    );
  }
}

class Effect2Settings extends StatelessWidget {
  const Effect2Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(8, (index) {
            return Container(
              width: double.infinity,
              height: 54,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF222222),
              ),
            );
          }),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Settings'),
    );
  }
}

class SelectDevicePage extends StatelessWidget {
  const SelectDevicePage({
    Key? key,
    required this.onDeviceSelected,
  }) : super(key: key);

  final void Function(String deviceId) onDeviceSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select a nearby device:',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      return const Color(0xFF222222);
                    }),
                  ),
                  onPressed: () => onDeviceSelected('22n483nk5834'),
                  child:
                      Text('Bulb 22n483nk5834', style: TextStyle(fontSize: 24)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaitingPage extends StatefulWidget {
  const WaitingPage({
    Key? key,
    required this.message,
    required this.onWaitComplete,
  }) : super(key: key);

  final String message;
  final VoidCallback onWaitComplete;

  @override
  _WaitingPageState createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  void initState() {
    super.initState();
    _startWaiting();
  }

  Future<void> _startWaiting() async {
    await Future<dynamic>.delayed(const Duration(seconds: 3));

    if (mounted) {
      widget.onWaitComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 32),
              Text(widget.message),
            ],
          ),
        ),
      ),
    );
  }
}

class FinishedPage extends StatelessWidget {
  const FinishedPage({
    Key? key,
    required this.onFinishPressed,
  }) : super(key: key);

  final VoidCallback onFinishPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF222222),
                ),
                child: Center(
                  child: Icon(Icons.lightbulb, size: 175, color: Colors.white),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Bulb added!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) {
                    return const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12);
                  }),
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    return const Color(0xFF222222);
                  }),
                  shape: MaterialStateProperty.resolveWith((states) {
                    return StadiumBorder();
                  }),
                ),
                onPressed: onFinishPressed,
                child: Text('Finish', style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
