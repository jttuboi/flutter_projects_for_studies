import 'dart:convert';

import 'package:http/http.dart' as http;

const serverIp = '10.0.2.2:4040';

abstract class IApiService {
  Future<String> attemptLogIn(String username, String password);

  Future<int> attemptSignUp(String username, String password);

  Future<String> getData(String jwt);
}

class HttpApiService implements IApiService {
  @override
  Future<String> attemptLogIn(String username, String password) async {
    var response = await http.post(
      Uri.http(serverIp, '/login'),
      body: jsonEncode({'username': username, 'password': password}),
    );

    print(response.statusCode);
    return (response.statusCode == 200) ? response.body : '';
  }

  @override
  Future<int> attemptSignUp(String username, String password) async {
    var response = await http.post(
      Uri.http(serverIp, '/signup'),
      body: jsonEncode({'username': username, 'password': password}),
    );

    print(response.statusCode);
    return response.statusCode;
  }

  @override
  Future<String> getData(String jwt) async {
    var response = await http
        .get(Uri.http(serverIp, '/data'), headers: {'Authorization': jwt});

    print(response.statusCode);
    return response.body;
  }
}
