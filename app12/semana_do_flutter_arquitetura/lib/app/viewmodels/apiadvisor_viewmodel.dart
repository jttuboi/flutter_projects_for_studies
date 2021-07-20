import 'package:flutter/foundation.dart';
import 'package:semana_do_flutter_arquitetura/app/repositories/apiadvisor_interface.dart';
import 'package:semana_do_flutter_arquitetura/app/models/apiadvisor_model.dart';

class ApiadvisorViewModel {
  ApiadvisorViewModel(this.repository);

  final IApiadvisor repository;
  final apiadvisorModel = ValueNotifier<ApiadvisorModel>(
      ApiadvisorModel(country: "TEST", date: "2020-01-01", text: "blablabla"));

  void fill() async {
    apiadvisorModel.value = await repository.getTime();
  }
}
