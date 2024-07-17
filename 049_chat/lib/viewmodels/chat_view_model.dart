import 'package:chat/chat.dart';

import '../entities/local_message.dart';
import 'base_view_model.dart';

class ChatViewModel extends BaseViewModel {
  ChatViewModel(super.database);

  String _chatId = '';
  int otherMessages = 0;
  String get chatId => _chatId;

  Future<List<LocalMessage>> getMessages(String chatId) async {
    final messages = await database.findMessages(chatId);
    if (messages.isNotEmpty) _chatId = chatId;
    return messages;
  }

  Future<void> sentMessage(Message message) async {
    // final chatId = message.groupId != null ? message.groupId : message.to;
    final localMessage = LocalMessage(id: '1', chatId: chatId, message: message, receipt: ReceiptStatus.sent);

    if (_chatId.isNotEmpty) return database.addMessage(localMessage);
    _chatId = localMessage.chatId;
    await addMessage(localMessage);
  }

  Future<void> receivedMessage(Message message) async {
    // final chatId = message.groupId != null ? message.groupId : message.from;
    final localMessage = LocalMessage(id: '1', chatId: chatId, message: message, receipt: ReceiptStatus.delivered);

    if (_chatId.isEmpty) _chatId = localMessage.chatId;
    if (localMessage.chatId != _chatId) otherMessages++;
    await addMessage(localMessage);
  }

  // Future<void> updateMessageReceipt(Receipt receipt) async {
  //   await database.updateMessageReceipt(receipt.messageId, receipt.status);
  // }
}
