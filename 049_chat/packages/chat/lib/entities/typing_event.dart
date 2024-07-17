// ignore_for_file: public_member_api_docs, sort_constructors_first
enum Typing {
  start,
  stop,
  ;

  String value() {
    return toString().split('.').last;
  }

  static Typing fromString(String event) {
    return Typing.values.firstWhere((element) => element.value() == event);
  }
}

class TypingEvent {
  const TypingEvent({
    required this.id,
    required this.from,
    required this.to,
    required this.event,
  });

  final String id;
  final String from;
  final String to;
  final Typing event;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'from': from,
      'to': to,
      'event': event.value(),
    };
  }

  static TypingEvent? fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return null;

    return TypingEvent(
      id: map['id'] as String,
      from: map['from'] as String,
      to: map['to'] as String,
      event: Typing.fromString(map['event']),
    );
  }
}
