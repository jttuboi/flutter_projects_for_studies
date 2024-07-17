// ignore_for_file: public_member_api_docs, sort_constructors_first
enum ReceiptStatus {
  sent,
  delivered,
  read,
  ;

  String value() {
    return toString().split('.').last;
  }

  static ReceiptStatus fromString(String status) {
    return ReceiptStatus.values.firstWhere((element) => element.value() == status);
  }
}

class Receipt {
  const Receipt({
    required this.id,
    required this.recipient,
    required this.messageId,
    required this.status,
    required this.timestamp,
  });

  final String id;
  final String recipient;
  final String messageId;
  final ReceiptStatus status;
  final DateTime timestamp;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'recipient': recipient,
      'message_id': messageId,
      'status': status.value(),
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static Receipt? fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return null;

    return Receipt(
      id: map['id'] as String,
      recipient: map['recipient'] as String,
      messageId: map['message_id'] as String,
      status: ReceiptStatus.fromString(map['status']),
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
