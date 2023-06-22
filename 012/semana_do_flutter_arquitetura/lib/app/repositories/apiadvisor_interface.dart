import 'package:semana_do_flutter_arquitetura/app/models/apiadvisor_model.dart';

abstract class IApiadvisor {
  Future<ApiadvisorModel> getTime();
}
