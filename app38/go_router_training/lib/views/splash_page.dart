import 'package:flutter/material.dart';
import 'package:go_router_training/router/route_utils.dart';
import 'package:go_router_training/services/app_service.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late AppService _appService;

  @override
  void initState() {
    super.initState();
    // recupera o AppService e em seguida inicia o app
    _appService = Provider.of<AppService>(context, listen: false);
    onStartUp();
  }

  Future<void> onStartUp() async {
    // aqui ele irá startar o estado do app
    await _appService.onAppStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppPage.splash.toTitle),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
