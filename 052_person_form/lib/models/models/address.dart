import 'package:formz/formz.dart';

enum AddressValidationError { invalid }

class Address extends FormzInput<String, AddressValidationError> {
  const Address.pure([String value = '']) : super.pure(value);
  const Address.dirty([String value = '']) : super.dirty(value);

  @override
  AddressValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : AddressValidationError.invalid;
  }
}
