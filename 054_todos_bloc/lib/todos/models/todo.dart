import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  const Todo({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.completed,
  });

  final String id;
  final String title;
  final String subtitle;
  final bool completed;

  static const empty = Todo(
    id: '',
    title: '',
    subtitle: '',
    completed: false,
  );

  @override
  List<Object?> get props => [id, title, subtitle, completed];

  Todo copyWith({
    String? id,
    String? title,
    String? subtitle,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      completed: completed ?? this.completed,
    );
  }
}
