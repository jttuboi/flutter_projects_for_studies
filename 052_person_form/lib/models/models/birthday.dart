import 'package:formz/formz.dart';

enum BirthdayValidationError { invalid }

class Birthday extends FormzInput<String, BirthdayValidationError> {
  const Birthday.pure([String value = '']) : super.pure(value);
  const Birthday.dirty([String value = '']) : super.dirty(value);

  // https://www.regular-expressions.info/dates.html
  static final _birthdayRegex = RegExp(r'^(0[1-9]|[12][0-9]|3[01])[-/.](0[1-9]|1[012])[-/.](19|20)\d\d$');

  @override
  BirthdayValidationError? validator(String? value) {
    return _birthdayRegex.hasMatch(value ?? '') ? null : BirthdayValidationError.invalid;
  }

  DateTime toDateTime() {
    final date = value.split('/');
    return DateTime(int.parse(date[2]), int.parse(date[1]), int.parse(date[0]));
  }

  static String toScreenFormat(DateTime birthday) {
    return '${birthday.day.toString().padLeft(2, '0')}/${birthday.month.toString().padLeft(2, '0')}/${birthday.year}';
  }
}
