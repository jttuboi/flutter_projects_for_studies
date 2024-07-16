class Message {
  Message({
    required this.id,
    required this.from,
    required this.to,
    required this.contents,
    required this.timestamp,
  });

  String? id;
  final String from;
  final String to;
  final String contents;
  final DateTime timestamp;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from': from,
      'to': to,
      'contents': contents,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static Message? fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return null;

    return Message(
      id: map['id'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      contents: map['contents'] as String,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }
}
