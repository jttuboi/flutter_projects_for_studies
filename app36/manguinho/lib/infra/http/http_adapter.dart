import 'dart:convert';

import 'package:http/http.dart';
import 'package:manguinho/data/data.dart';

class HttpAdapter implements HttpClient {
  HttpAdapter(this.client);

  final Client client;

  Future<Map> request({required String url, required String method, Map body = const {}}) async {
    final headers = {'content-type': 'application/json', 'accept': 'application/json'};
    final jsonBody = body.isNotEmpty ? jsonEncode(body) : null;

    var response = await client.post(Uri.parse(url), headers: headers, body: jsonBody);
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : {};
    } else {
      return {};
    }
  }
}
