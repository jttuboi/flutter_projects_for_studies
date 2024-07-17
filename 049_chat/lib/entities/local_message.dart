import 'package:chat/chat.dart';

class LocalMessage {
  const LocalMessage({
    required this.id,
    required this.chatId,
    required this.message,
    required this.receipt,
  });

  final String id;
  final String chatId;
  final Message message;
  final ReceiptStatus receipt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': message.id,
      'chat_id': chatId,
      ...message.toMap(),
      'receipt': receipt.value(),
    };
  }

  static LocalMessage? fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return null;

    final message = Message(
      id: map['id'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      contents: map['contents'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );

    return LocalMessage(
      id: map['id'] as String,
      chatId: map['chat_id'] as String,
      message: message,
      receipt: ReceiptStatus.fromString(map['receipt'] as String),
    );
  }
}
