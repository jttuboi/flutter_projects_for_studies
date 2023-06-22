import 'package:flutter/cupertino.dart';
import 'package:semana_do_flutter_arquitetura/app/models/apiadvisor_model.dart';
import 'package:semana_do_flutter_arquitetura/app/viewmodels/apiadvisor_viewmodel.dart';

class HomeController {
  HomeController(this.viewModel);

  final ApiadvisorViewModel viewModel;

  ValueNotifier<ApiadvisorModel> get time => viewModel.apiadvisorModel;

  void getTime() {
    viewModel.fill();
  }
}
