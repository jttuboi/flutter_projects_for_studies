import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_training/router/route_utils.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({this.error = '', Key? key}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppPage.error.toTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error),
            TextButton(
              onPressed: () => GoRouter.of(context).goNamed(AppPage.home.toName),
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
