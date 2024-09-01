class Error {
  const Error({required this.tag, required this.message});

  final String tag;
  final String message;

  Map<String, dynamic> toMap() {
    return {
      'tag': tag,
      'message': message,
    };
  }
}

extension ErrorsExtension on List<Error> {
  Map<String, dynamic> toErrorsMap() {
    return {
      'errors': map<Map<String, dynamic>>((error) => error.toMap()).toList(),
    };
  }
}
