import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manguinho/presentation/presentation.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late StreamLoginPresenter sut;
  late ValidationSpy validation;
  late String email;

  When mockValidationCall({String? field}) {
    return when(() => validation.validate(field: field ?? any(named: 'field'), value: any(named: 'value')));
  }

  void mockValidation({String? field, String? value}) {
    mockValidationCall(field: field).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();

    mockValidation();
  });

  test('should call validation with correct email', () {
    sut.validateEmail(email);

    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });

  test('should emit email error if validation fails', () {
    mockValidation(value: 'error');

    expectLater(sut.emailErrorStream, emits('error'));

    sut.validateEmail(email);
  });
}

class ValidationSpy extends Mock implements Validation {}
