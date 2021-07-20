import 'package:mocktail/mocktail.dart';
import 'package:semana_do_flutter_testes_unitarios/person.dart';
import 'package:semana_do_flutter_testes_unitarios/person_bloc.dart';
import 'package:semana_do_flutter_testes_unitarios/person_repository.dart';
import 'package:semana_do_flutter_testes_unitarios/person_state.dart';
import 'package:flutter_test/flutter_test.dart';

class PersonRepositoryMock extends Mock implements PersonRepository {}

void main() {
  final repository = PersonRepositoryMock();
  final bloc = PersonBloc(repository);
  final person =
      Person(id: 1, name: 'Bill', age: 29, height: 1.77, weight: 64.4);

  test('deve retornar uma lista de person', () async {
    when(() => repository.getPerson()).thenAnswer((_) async => <Person>[
          person,
          person,
        ]);

    bloc.add(PersonEvent.fetch);

    await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<PersonLoadingState>(),
          isA<PersonListState>(),
        ]));
  });

  test('deve disparar um error', () async {
    when(() => repository.getPerson()).thenThrow(Exception());

    bloc.add(PersonEvent.fetch);

    await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<PersonLoadingState>(),
          isA<PersonErrorState>(),
        ]));
  });
}
