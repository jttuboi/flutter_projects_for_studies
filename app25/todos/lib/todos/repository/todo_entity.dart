// ignore_for_file: sort_constructors_first

import 'dart:convert';

// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: avoid_positional_boolean_parameters

class TodoEntity {
  const TodoEntity(
    this.id,
    this.task,
    this.note,
    this.complete,
  );

  final String id;
  final String task;
  final String note;
  final bool complete;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TodoEntity && other.id == id && other.task == task && other.note == note && other.complete == complete;
  }

  @override
  int get hashCode {
    return id.hashCode ^ task.hashCode ^ note.hashCode ^ complete.hashCode;
  }

  @override
  String toString() {
    return 'TodoEntity($id, $task, $note, $complete)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'note': note,
      'complete': complete,
    };
  }

  factory TodoEntity.fromMap(Map<String, dynamic> map) {
    return TodoEntity(
      map['id'],
      map['task'],
      map['note'],
      map['complete'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoEntity.fromJson(String source) => TodoEntity.fromMap(json.decode(source));
}
