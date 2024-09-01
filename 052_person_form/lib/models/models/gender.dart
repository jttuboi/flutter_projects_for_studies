import 'package:formz/formz.dart';

enum GenderValidationError { invalid }

class Gender extends FormzInput<List<bool>, GenderValidationError> {
  const Gender.pure([List<bool> value = const [false, false]]) : super.pure(value);
  const Gender.dirty([List<bool> value = const [false, false]]) : super.dirty(value);

  @override
  GenderValidationError? validator(List<bool>? value) {
    return ((value?[0] == true && value?[1] == true) || (value?[0] == false && value?[1] == false)) ? GenderValidationError.invalid : null;
  }

  String toGender() {
    if (value[1]) {
      return 'f';
    }
    return 'm';
  }

  static List<bool> toScreenFormat(String gender) {
    if (gender == 'f') {
      return [false, true];
    }
    return [true, false];
  }
}
