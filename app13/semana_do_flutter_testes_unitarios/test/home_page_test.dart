import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semana_do_flutter_testes_unitarios/bloc_provider.dart';
import 'package:semana_do_flutter_testes_unitarios/home_page.dart';

import 'package:semana_do_flutter_testes_unitarios/person.dart';
import 'package:semana_do_flutter_testes_unitarios/person_bloc.dart';
import 'package:semana_do_flutter_testes_unitarios/person_repository.dart';

class PersonRepositoryMock extends Mock implements PersonRepository {}

void main() {
  final repository = PersonRepositoryMock();
  final bloc = PersonBloc(repository);
  final person =
      Person(id: 1, name: 'Bill', age: 29, height: 1.77, weight: 64.4);

  testWidgets('deve mostrar todos os estados na tela',
      (WidgetTester tester) async {
    when(() => repository.getPerson()).thenAnswer((_) async => <Person>[
          person,
          person,
        ]);

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        bloc: bloc,
        child: HomePage(),
      ),
    ));

    final textButton = find.byType(TextButton);
    expect(textButton, findsOneWidget);
    final loading = find.byType(CircularProgressIndicator);
    expect(loading, findsNothing);
    final listPersons = find.byType(ListView);
    expect(listPersons, findsNothing);

    await tester.tap(textButton);

    await tester.runAsync(() => bloc.stream.first);
    await tester.pump();
    expect(loading, findsOneWidget);

    await tester.runAsync(() => bloc.stream
        .first); // libera para proxima linha do teste só após receber algo
    await tester.pump(); // ativa a mudança de frame
    expect(listPersons, findsOneWidget);
  });
}
