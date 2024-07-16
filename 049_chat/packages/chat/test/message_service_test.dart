// ignore_for_file: prefer_final_locals, omit_local_variable_types, avoid_types_on_closure_parameters

import 'package:chat/models/message.dart';
import 'package:chat/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Rethinkdb r = Rethinkdb();
  Connection connection;
  MessageService sut;

  setUp(() async {
    connection = await r.connect(host: '127.0.0.1', port: 28015);
    await createDb(r, connection);
    sut = MessageService(r, connection);
  });

  tearDown(() async {
    sut.dispose();
    await cleanDb(r, connection);
  });

  final user = User.fromMap({
    'id': '1234',
    'active': true,
    'last_seen': DateTime.now(),
  });

  final user2 = User.fromMap({
    'id': '1111',
    'active': true,
    'last_seen': DateTime.now(),
  });

  test('sent message successfully', () async {
    Message message = Message(
      id: '', // não precisa
      from: user?.id ?? '',
      to: '3456',
      timestamp: DateTime.now(),
      contents: 'this is a message',
    );

    final result = await sut.send(user);
    expect(result, true);
  });

  test('successfully subscribe and receive messages', () async {
    sut.messages(activeUser: user2).listen(
          expectAsync1((Message message) {
            expect(message.to, user2!.id);
            expect(message.id, isNotEmpty);
          }, count: 2),
        );

    Message message = Message(
      id: '', // não precisa
      from: user.id,
      to: user2.id,
      timestamp: DateTime.now(),
      contents: 'this is a message',
    );

    Message secondMessage = Message(
      id: '', // não precisa
      from: user.id,
      to: user2.id,
      timestamp: DateTime.now(),
      contents: 'this is another message',
    );

    await sut.send(message);
    await sut.send(secondMessage);
  });

  test('successfully subscribe and receive new messages', () async {
    Message message = Message(
      id: '', // não precisa
      from: user.id,
      to: user2.id,
      timestamp: DateTime.now(),
      contents: 'this is a message',
    );

    Message secondMessage = Message(
      id: '', // não precisa
      from: user.id,
      to: user2.id,
      timestamp: DateTime.now(),
      contents: 'this is another message',
    );

    await sut.send(message);
    await sut.send(secondMessage).whenComplete(() {
      return sut.messages(activeUser: user2).listen(
            expectAsync1((Message message) {
              expect(message.to, user2!.id);
            }, count: 2),
          );
    });
  });
}
