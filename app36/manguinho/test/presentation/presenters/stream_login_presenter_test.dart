import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manguinho/presentation/presentation.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late StreamLoginPresenter sut;
  late ValidationSpy validation;
  late String email;
  late String password;

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
    password = faker.internet.password();

    mockValidation();
  });

  test('should call validation with correct email', () {
    sut.validateEmail(email);

    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });

  test('should emit email error if validation fails', () {
    // Não notificar o emailErrorStream se o valor for igual ao último.
    // esse teste deve verificar que envia apenas o primeiro state 'error' quando
    // os seguintes serão iguais 'error'. (em geral, não deve ficar enviando states repetidos ao anterior.)
    mockValidation(value: 'error');

    // o expectAsync1 já é executado logo após o listen escutar algo
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);

    ////////////////////////////////////////////////////////////////////////////
    // o expectLater ele irá esperar por algum valor da stream chegar, quando chega o valor ele compara.
    // a comparação utilizada emitsInOrder compara com os valores emitidos pela stream na ordem esperada.
    // os validateEmail são os métodos do presenter que emitem o valor pelo stream, nesse caso ele estará emitindo 2 vezes o mesmo valor.

    //expectLater(sut.emailErrorStream, emitsInOrder(['error', 'error']));
    //sut.validateEmail(email);
    //sut.validateEmail(email);
  });

  test('should emit null if validation succeeds', () {
    mockValidation();
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, true)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('should call validation with correct password', () {
    sut.validatePassword(password);

    verify(() => validation.validate(field: 'password', value: password)).called(1);
  });
}

class ValidationSpy extends Mock implements Validation {}
