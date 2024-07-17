class Encrypter {
  Encrypter(AES _);

  Base64 encrypt(String _, {IV? iv}) {
    return Base64();
  }

  String decrypt(Encrypted _, {IV? iv}) {
    return '';
  }
}

class AES {
  AES(Key _);
}

class Key {
  Key.fromLength(int _);
}

class Base64 {
  String get base64 => '';
}

class IV {
  IV.fromLength(int _);
}

class Encrypted {
  Encrypted.fromBase64(String _);
}
