import '../entities/chat.dart';
import '../entities/local_message.dart';

abstract class IDatabase {
  const IDatabase();

  Future<void> addChat(Chat chat);

  Future<void> addMessage(LocalMessage message);

  Future<Chat> findChat(String chatId);

  Future<List<Chat>> findChats();

  Future<void> updateMessage(LocalMessage message);

  Future<List<LocalMessage>> findMessages(String chatId);

  Future<void> deleteChat(String chatId);
}
