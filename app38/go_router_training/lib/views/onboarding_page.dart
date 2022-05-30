import 'package:flutter/material.dart';
import 'package:go_router_training/router/route_utils.dart';
import 'package:go_router_training/services/app_service.dart';
import 'package:provider/provider.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppPage.onBoarding.toTitle),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => appService.onboarding = true,
          child: const Text("Done"),
        ),
      ),
    );
  }
}
