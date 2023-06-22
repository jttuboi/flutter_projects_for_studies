import 'package:architectures/stores/app_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = context.read<AppStore>();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(store.picture),
            Text(store.name),
            Text(store.email),
          ],
        ),
      ),
    );
  }
}
