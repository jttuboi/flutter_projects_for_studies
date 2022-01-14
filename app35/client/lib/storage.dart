import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class IStorage {
  Future<String> get(String key);

  void store(String key, String value);
}

class SecureStorage implements IStorage {
  final storage = FlutterSecureStorage();

  @override
  Future<String> get(String key) async {
    return (await storage.read(key: key)) ?? '';
  }

  @override
  void store(String key, String value) {
    storage.write(key: key, value: value);
  }
}
