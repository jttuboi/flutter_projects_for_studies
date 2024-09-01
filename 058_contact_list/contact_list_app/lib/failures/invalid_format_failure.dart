import '../services/result/failure.dart';

class InvalidFormatFailure extends Failure {
  const InvalidFormatFailure() : super(tag: 'invalid_format', messageForUser: 'O formato dos dados estão inválidos.');
}
