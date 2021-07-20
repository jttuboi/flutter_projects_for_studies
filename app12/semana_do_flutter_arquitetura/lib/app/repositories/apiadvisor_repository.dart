import 'package:semana_do_flutter_arquitetura/app/repositories/apiadvisor_interface.dart';
import 'package:semana_do_flutter_arquitetura/app/services/client_http_interface.dart';
import 'package:semana_do_flutter_arquitetura/app/models/apiadvisor_model.dart';

class ApiadvisorRepository implements IApiadvisor {
  ApiadvisorRepository(this.client);

  final IClientHttp client;

  @override
  Future<ApiadvisorModel> getTime() async {
    var json = await client.get("http://...");

    ApiadvisorModel model = ApiadvisorModel.fromJson(json[0]);
    return model;
  }
}
