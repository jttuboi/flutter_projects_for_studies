import 'local_message.dart';

class Chat {
  Chat(
    this.id, {
    this.messages = const [],
    this.mostRecent,
  });

  final String id;

  List<LocalMessage> messages;
  LocalMessage? mostRecent;

  int unread = 0;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  static Chat? fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return null;

    return Chat(map['id'] as String);
  }
}
