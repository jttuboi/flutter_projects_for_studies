import 'package:formz/formz.dart';

enum PasswordValidationError { empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    // se tem alguma coisa escrita, retorna null
    // se nao está vazio, retorna o erro "vazio"
    return value?.isNotEmpty == true ? null : PasswordValidationError.empty;
  }
}
