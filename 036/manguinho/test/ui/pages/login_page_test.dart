import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manguinho/ui/pages/pages.dart';
import 'package:mocktail/mocktail.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  late LoginPresenter presenter;
  late StreamController<String?> emailErrorController;
  late StreamController<String?> passwordErrorController;
  late StreamController<bool> isFormValidController;
  late StreamController<bool> isLoadingController;
  late StreamController<String> authenticationErrorController;

  void initStreams() {
    emailErrorController = StreamController<String?>();
    passwordErrorController = StreamController<String?>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
    authenticationErrorController = StreamController<String>();
  }

  void mockStreams() {
    when(() => presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => presenter.passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(() => presenter.isFormValidStream).thenAnswer((_) => isFormValidController.stream);
    when(() => presenter.isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(() => presenter.authenticationErrorStream).thenAnswer((_) => authenticationErrorController.stream);
  }

  void closeStreams() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
    authenticationErrorController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    initStreams();
    mockStreams();
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(presenter),
    ));
  }

  tearDown(() {
    closeStreams();
  });

  testWidgets('should load with correct initial state', (tester) async {
    await loadPage(tester);

    expect(
      find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text)),
      findsOneWidget,
      reason: 'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text',
    );

    expect(
      find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)),
      findsOneWidget,
      reason: 'when a TextFormField has only one text child, means it has no errors, since one of the childs is always the label text',
    );

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('should call validate with correct values', (tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    when(() => presenter.validateEmail(email)).thenReturn(null);
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(() => presenter.validateEmail(email)).called(1);

    final password = faker.internet.password();
    when(() => presenter.validatePassword(password)).thenReturn(null);
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(() => presenter.validatePassword(password)).called(1);
  });

  testWidgets('should presenter error if email is invalid', (tester) async {
    await loadPage(tester);

    emailErrorController.add('any error');

    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('should presenter no error if email is valid', (tester) async {
    await loadPage(tester);

    emailErrorController.add(null);

    await tester.pump();

    expect(find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text)), findsOneWidget);
  });

  testWidgets('should presenter no error if email is valid', (tester) async {
    await loadPage(tester);

    emailErrorController.add('');

    await tester.pump();

    expect(find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text)), findsOneWidget);
  });

  testWidgets('should presenter error if password is invalid', (tester) async {
    await loadPage(tester);

    passwordErrorController.add('any error');

    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('should presenter no error if password is valid', (tester) async {
    await loadPage(tester);

    passwordErrorController.add(null);

    await tester.pump();

    expect(find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)), findsOneWidget);
  });

  testWidgets('should presenter no error if password is valid', (tester) async {
    await loadPage(tester);

    passwordErrorController.add('');

    await tester.pump();

    expect(find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)), findsOneWidget);
  });

  testWidgets('should enable button if form is valid', (tester) async {
    await loadPage(tester);

    isFormValidController.add(true);

    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('should disable button if form is invalid', (tester) async {
    await loadPage(tester);

    isFormValidController.add(false);

    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('should call authentication on form submit', (tester) async {
    await loadPage(tester);
    when(() => presenter.auth()).thenAnswer((_) async {});

    isFormValidController.add(true);

    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(() => presenter.auth()).called(1);
  });

  testWidgets('should show loading', (tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should hide loading', (tester) async {
    await loadPage(tester);
    isLoadingController.add(true);
    await tester.pump();

    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('should show error message if authentication fails', (tester) async {
    await loadPage(tester);

    authenticationErrorController.add('main error');
    await tester.pump();

    expect(find.text('main error'), findsOneWidget);
  });

  testWidgets('should close streams on dispose', (tester) async {
    await loadPage(tester);

    addTearDown(() {
      verify(() => presenter.dispose()).called(1);
    });
  });
}
