import 'package:encrypt/encrypt.dart';

import 'encryption_service_interface.dart';

class EncryptionService implements IEncryptionService {
  EncryptionService(this._encrypter);

  final Encrypter _encrypter;
  final _iv = IV.fromLength(16);

  @override
  String encrypt(String text) {
    return _encrypter.encrypt(text, iv: _iv).base64;
  }

  @override
  String decrypt(String encryptedText) {
    final encrypted = Encrypted.fromBase64(encryptedText);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }
}
