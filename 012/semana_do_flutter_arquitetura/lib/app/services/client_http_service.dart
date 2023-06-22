import 'package:dio/dio.dart';
import 'package:semana_do_flutter_arquitetura/app/services/client_http_interface.dart';

class ClientHttpService implements IClientHttp {
  final Dio dio = Dio();

  @override
  void addToken(String token) {}

  @override
  Future get(String url) async {
    // var response = await dio.get(url);
    // return response.data;
    return [
      {
        "country": "BR",
        "date": "2020-05-29",
        "text":
            "dados que vem da internet. como não tenho acesso ao mesmo link do tutorial, então estou criando esse local test.",
      }
    ];
  }
}
