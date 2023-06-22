import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    // se tem alguma coisa escrita, retorna null
    // se nao está vazio, retorna o erro "vazio"
    return value?.isNotEmpty == true ? null : UsernameValidationError.empty;
  }
}
