import 'package:flutter/foundation.dart';
import 'package:semana_do_flutter_arquitetura/app/repositories/apiadvisor_interface.dart';
import 'package:semana_do_flutter_arquitetura/app/models/apiadvisor_model.dart';

class ApiadvisorViewModel {
  ApiadvisorViewModel(this.repository);

  final IApiadvisor repository;
  final apiadvisorModel =
      ValueNotifier<ApiadvisorModel>(ApiadvisorModel.empty());

  void fill() async {
    try {
      apiadvisorModel.value = await repository.getTime();
    } catch (e) {
      apiadvisorModel.value = ApiadvisorModel.empty();
    }
  }
}
