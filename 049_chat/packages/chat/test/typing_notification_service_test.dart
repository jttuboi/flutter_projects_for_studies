// ignore_for_file: prefer_final_locals, omit_local_variable_types, avoid_types_on_closure_parameters

import 'package:chat/src/entities/typing_event.dart';
import 'package:chat/src/entities/user.dart';
import 'package:chat/src/fake/connection.dart';
import 'package:chat/src/fake/rethinkdb.dart';
import 'package:chat/src/services/typing_notification_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  Rethinkdb r = Rethinkdb();
  late Connection connection;
  late TypingNotificationService sut;

  setUp(() async {
    connection = await r.connect();
    await createDb(r, connection);
    sut = TypingNotificationService(r, connection);
  });

  tearDown(() async {
    await sut.dispose();
    await cleanDb(r, connection);
  });

  final user = User.fromMap({
    'id': '1234',
    'active': true,
    'last_seen': DateTime.now(),
  })!;

  final user2 = User.fromMap({
    'id': '1111',
    'active': true,
    'last_seen': DateTime.now(),
  })!;

  test('sent typing notification successfully', () async {
    TypingEvent typingEvent = TypingEvent(
      id: '', // não precisa
      from: user2.id ?? '',
      to: user.id ?? '',
      event: Typing.start,
    );

    final result = await sut.send(event: typingEvent, to: user);
    expect(result, true);
  });

  test('successfully subscribe and receive typing events', () async {
    sut.subscribe(user2, [user.id!]).listen(
      expectAsync1((TypingEvent event) {
        expect(event.from, user.id);
      }, count: 2),
    );

    TypingEvent typing = TypingEvent(
      id: '', // não precisa
      from: user2.id ?? '',
      to: user.id ?? '', event: Typing.start,
    );

    TypingEvent stopTyping = TypingEvent(
      id: '', // não precisa
      from: user2.id ?? '',
      to: user.id ?? '', event: Typing.stop,
    );

    await sut.send(event: typing, to: user2);
    await sut.send(event: stopTyping, to: user2);
  });
}
