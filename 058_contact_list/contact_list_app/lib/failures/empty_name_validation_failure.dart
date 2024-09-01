import '../services/result/failure.dart';
import '../utils/strings.dart';

class EmptyNameValidationFailure extends Failure {
  const EmptyNameValidationFailure() : super(tag: 'name', messageForUser: Strings.contactNameError);
}
