import 'package:flutter_test/flutter_test.dart';
import 'package:semana_do_flutter_testes_unitarios/person.dart';

void main() {
  final person =
      Person(id: 1, name: 'Bill', age: 29, height: 1.77, weight: 64.4);

  test('Imc deve vir 20.56', () {
    expect(person.imc, 20.56);
  });

  group('isOlder |', () {
    test('Se idade > 18, isOlder == true', () {
      expect(person.isOlder, true);
    });

    test('Se idade == 18, isOlder == true', () {
      final person =
          Person(id: 1, name: 'Bill', age: 18, height: 1.77, weight: 64.4);
      expect(person.isOlder, true);
    });
  });

  // https://mockapi.io/projects/60f6ee22eb48e700179197f8
}
