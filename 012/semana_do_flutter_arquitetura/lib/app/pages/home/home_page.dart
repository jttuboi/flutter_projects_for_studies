import 'package:flutter/material.dart';
import 'package:semana_do_flutter_arquitetura/app/models/apiadvisor_model.dart';
import 'package:semana_do_flutter_arquitetura/app/pages/home/components/custom_switch_widget.dart';
import 'package:semana_do_flutter_arquitetura/app/pages/home/home_controller.dart';
import 'package:semana_do_flutter_arquitetura/app/repositories/apiadvisor_repository.dart';
import 'package:semana_do_flutter_arquitetura/app/services/client_http_service.dart';
import 'package:semana_do_flutter_arquitetura/app/viewmodels/apiadvisor_viewmodel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController(
      ApiadvisorViewModel(ApiadvisorRepository(ClientHttpService())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Semana Flutter"),
      ),
      body: Column(
        children: [
          CustomSwitchWidget(),
          ValueListenableBuilder(
            valueListenable: controller.time,
            builder: (context, ApiadvisorModel model, child) {
              // if (model?.text == null) {
              if (model.country == "TEST") {
                return Center(child: CircularProgressIndicator());
              }
              return Text(model.text);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.timeline),
        onPressed: () {
          controller.getTime();
        },
      ),
    );
  }
}
