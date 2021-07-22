import 'package:flutter/material.dart';
import 'package:masterclass/stores/app.store.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppStore _store = Provider.of<AppStore>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(_store.picture),
            Text(_store.name),
            Text(_store.email),
          ],
        ),
      ),
    );
  }
}
