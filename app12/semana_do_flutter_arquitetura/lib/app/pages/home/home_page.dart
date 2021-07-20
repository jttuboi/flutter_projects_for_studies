import 'package:flutter/material.dart';
import 'package:semana_do_flutter_arquitetura/app/components/custom_switch_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Semana Flutter"),
      ),
      body: Center(
        child: CustomSwitchWidget(),
      ),
    );
  }
}
