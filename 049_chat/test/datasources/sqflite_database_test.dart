import 'package:chat/chat.dart';
import 'package:chat_app/datasources/sqflite_database.dart';
import 'package:chat_app/entities/chat.dart';
import 'package:chat_app/entities/local_message.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';

class MockSqfliteDatabase extends Mock implements Database {}

class MockBatch extends Mock implements Batch {}

void main() {
  late SqfliteDatabase sut;
  late MockSqfliteDatabase database;
  late MockBatch batch;

  setUp(() {
    database = MockSqfliteDatabase();
    batch = MockBatch();
    sut = SqfliteDatabase(database);
  });

  final message = Message.fromMap({
    'from': '111',
    'to': '222',
    'contents': 'hey',
    'timestamp': DateTime.parse('2021-04-01'),
    'id': '4444',
  });

  test('should perform insert of chat to the database', () async {
    final chat = Chat('1234');
    when(() => database.insert('chats', chat.toMap(), conflictAlgorithm: ConflictAlgorithm.replace)).thenAnswer((_) async => 1);

    await sut.addChat(chat);

    verify(() => database.insert('chats', chat.toMap(), conflictAlgorithm: ConflictAlgorithm.replace)).called(1);
  });

  test('should perform insert of message to the database', () async {
    final localMessage = LocalMessage(id: '1', chatId: '1234', message: message!, receipt: ReceiptStatus.sent);
    when(() => database.insert('messages', localMessage.toMap(), conflictAlgorithm: ConflictAlgorithm.replace)).thenAnswer((_) async => 1);

    await sut.addMessage(localMessage);

    verify(() => database.insert('messages', localMessage.toMap(), conflictAlgorithm: ConflictAlgorithm.replace)).called(1);
  });

  test('should perform a database query and return message', () async {
    final messageMap = [
      {
        'chat_id': '111',
        'id': '4444',
        'from': '111',
        'to': '222',
        'contents': 'hey',
        'receipt': 'sent',
        'timestamp': DateTime.parse('2021-04-01'),
      }
    ];
    when(() => database.query('messages', where: any(named: 'where'), whereArgs: any(named: 'whereArgs'))).thenAnswer((_) async => messageMap);

    final messages = await sut.findMessages('111');

    expect(messages.length, 1);
    expect(messages.first.chatId, '111');
    verify(() => database.query('messages', where: any(named: 'where'), whereArgs: any(named: 'whereArgs'))).called(1);
  });

  test('should perform database update on messages', () async {
    //arrange
    final localMessage = LocalMessage(id: '1', chatId: '1234', message: message!, receipt: ReceiptStatus.sent);
    when(() => database.update('messages', localMessage.toMap(), where: any(named: 'where'), whereArgs: any(named: 'whereArgs')))
        .thenAnswer((_) async => 1);

    //act
    await sut.updateMessage(localMessage);

    //assert
    verify(() => database.update('messages', localMessage.toMap(),
        where: any(named: 'where'), whereArgs: any(named: 'whereArgs'), conflictAlgorithm: ConflictAlgorithm.replace)).called(1);
  });

  test('should perform database batch delete of chat', () async {
    //arrange
    const chatId = '111';
    when(() => database.batch()).thenReturn(batch);

    //act
    await sut.deleteChat(chatId);

    //assert
    verifyInOrder([
      () => database.batch(),
      () => batch.delete('messages', where: any(named: 'where'), whereArgs: [chatId]),
      () => batch.delete('chats', where: any(named: 'where'), whereArgs: [chatId]),
      () => batch.commit(noResult: true)
    ]);
  });
}
