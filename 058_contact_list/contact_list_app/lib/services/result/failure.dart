import 'package:equatable/equatable.dart';

class Failure with EquatableMixin {
  const Failure({required this.tag, required this.messageForUser, this.stackTrace, this.error, this.exception});

  const Failure.noFailure()
      : tag = '',
        messageForUser = '',
        stackTrace = null,
        error = null,
        exception = null;

  final String tag;
  final String messageForUser;
  final StackTrace? stackTrace;
  final Object? error;
  final Exception? exception;

  @override
  List<Object> get props => [tag, messageForUser];

  bool get hasFailure => this != const Failure.noFailure();

  bool get hasNotFailure => this == const Failure.noFailure();
}
