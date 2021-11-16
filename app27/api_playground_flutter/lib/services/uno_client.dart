import 'package:api_playground_flutter/services/http_client_interface.dart';
import 'package:uno/uno.dart';

class UnoClient implements IHttpClient {
  final Uno uno = Uno();

  @override
  Future<dynamic> get(String url) async {
    var response = await uno(url: url, method: 'get');
    return response.data;
  }
}
