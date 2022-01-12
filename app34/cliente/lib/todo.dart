class Todo {
  Todo({
    required this.title,
    required this.message,
    required this.completed,
  });

  final String title;
  final String message;
  final bool completed;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'completed': completed,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      completed: map['completed'] ?? false,
    );
  }

  @override
  String toString() => 'Todo(title: $title, message: $message, completed: $completed)';
}
