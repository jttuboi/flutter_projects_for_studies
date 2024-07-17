abstract class IEncryptionService {
  const IEncryptionService();

  String encrypt(String text);
  String decrypt(String encryptedText);
}
