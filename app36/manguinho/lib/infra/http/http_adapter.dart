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
    } else if (response.statusCode == 204) {
      return {};
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest;
    } else if (response.statusCode == 401) {
      throw HttpError.unauthorized;
    } else if (response.statusCode == 403) {
      throw HttpError.forbidden;
    } else if (response.statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
  }
}
