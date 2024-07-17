// ignore_for_file: unnecessary_lambdas

import 'package:sqflite/sqflite.dart';

import '../entities/chat.dart';
import '../entities/local_message.dart';
import 'database_interface.dart';

class SqfliteDatabase implements IDatabase {
  const SqfliteDatabase(this._db);

  final Database _db;

  @override
  Future<void> addChat(Chat chat) async {
    await _db.insert('chats', chat.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> addMessage(LocalMessage message) async {
    await _db.insert('messages', message.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteChat(String chatId) async {
    final batch = _db.batch();
    batch
      ..delete('messages', where: 'chat_id = ?', whereArgs: [chatId])
      ..delete('chats', where: 'id = ?', whereArgs: [chatId]);
    await batch.commit(noResult: true);
  }

  @override
  Future<Chat> findChat(String chatId) async {
    return await _db.transaction((txn) async {
      final listOfChatMaps = await txn.query('chats', where: 'id = ?', whereArgs: [chatId]);

      final unread = Sqflite.firstIntValue(await txn.rawQuery(
        'SELECT COUNT(*) FROM MESSAGES WHERE chat_id = ? AND receipt = ?',
        [chatId, 'delivered'],
      ));

      final mostRecentMessage = await txn.query(
        'messages',
        where: 'chat_id = ?',
        whereArgs: [chatId],
        orderBy: 'created_at DESC',
        limit: 1,
      );

      final chat = Chat.fromMap(listOfChatMaps.first);
      chat!.unread = unread!;
      chat.mostRecent = LocalMessage.fromMap(mostRecentMessage.first);
      return chat;
    });
  }

  @override
  Future<List<Chat>> findChats() async {
    return _db.transaction((txn) async {
      final chatsWithLatestMessage = await txn.rawQuery('''
        SELECT messages.* FROM (
          SELECT chat_id, MAX(created_at) AS created_at
          FROM messages
          GROUP BY chat_id
        ) AS latest_messages
        INNER JOIN messages
        ON messages.chat_id = latest_messages.chat_id
        AND messages.created_at = latest_messages.created_at
      ''');

      final chatsWithUnreadMessages = await txn.rawQuery('''
        SELECT chat_id, count(*) as unread
        FROM messages
        WHERE receipt = ?
        GROUP BY chat_id
      ''', ['delivered']);

      return chatsWithLatestMessage.map<Chat>((row) {
        final unread = int.tryParse(
          chatsWithUnreadMessages.firstWhere((element) {
            return row['chat_id'] == element['chat_id'];
          }, orElse: () {
            return {'unread': 0};
          })['unread']! as String,
        );

        final chat = Chat.fromMap(row);
        chat!.unread = unread!;
        chat.mostRecent = LocalMessage.fromMap(row);
        return chat;
      }).toList();
    });
  }

  @override
  Future<List<LocalMessage>> findMessages(String chatId) async {
    final listOfMaps = await _db.query('messages', where: 'chat_id = ?', whereArgs: [chatId]);

    return listOfMaps.map<LocalMessage>((map) => LocalMessage.fromMap(map)!).toList();
  }

  @override
  Future<void> updateMessage(LocalMessage message) async {
    await _db.update(
      'messages',
      message.toMap(),
      where: 'id = ?',
      whereArgs: [message.message.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
