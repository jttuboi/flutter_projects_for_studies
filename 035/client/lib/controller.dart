import 'dart:convert';

import 'package:client/api_service.dart';
import 'package:client/storage.dart';

abstract class IController {
  Future<String> get jwtOrEmpty;

  Future<bool> get logged;

  Future<bool> login(String username, String password);

  Future<int> signup(String username, String password);

  Future<Map<String, dynamic>> getHomeViewModel();
}

class Controller implements IController {
  Controller(this.service, this.storage);

  final IApiService service;
  final IStorage storage;

  Future<String> get jwtOrEmpty async {
    return await storage.get('jwt');
  }

  Future<bool> get logged async {
    var jwt = await jwtOrEmpty;
    var jwtData = jwt.split('.');

    if (jwtData.length != 3) {
      return false;
    }

    var payload =
        json.decode(utf8.decode(base64.decode(base64.normalize(jwtData[1]))));
    if (!DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000)
        .isAfter(DateTime.now())) {
      return false;
    }

    return true;
  }

  Future<bool> login(String username, String password) async {
    var jwt = await service.attemptLogIn(username, password);

    if (jwt.isNotEmpty) {
      storage.store('jwt', jwt);
      return true;
    }

    return false;
  }

  Future<int> signup(String username, String password) async {
    return await service.attemptSignUp(username, password);
  }

  @override
  Future<Map<String, dynamic>> getHomeViewModel() async {
    final jwt = await jwtOrEmpty;

    final payload = jsonDecode(
        utf8.decode(base64.decode(base64.normalize(jwt.split('.')[1]))));

    return {
      'username': payload['username'],
      'data': await service.getData(jwt),
    };
  }
}
