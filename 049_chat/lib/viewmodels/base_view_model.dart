import 'package:flutter/widgets.dart';

import '../datasources/database_interface.dart';
import '../entities/chat.dart';
import '../entities/local_message.dart';

abstract class BaseViewModel {
  BaseViewModel(this.database);

  final IDatabase database;

  @protected
  Future<void> addMessage(LocalMessage message) async {
    if (!(await _isExistingChat(message.chatId))) {
      await _createNewChat(message.chatId);
    }
    await database.addMessage(message);
  }

  Future<bool> _isExistingChat(String chatId) async {
    return await database.findChat(chatId) != null;
  }

  Future<void> _createNewChat(String chatId) async {
    final chat = Chat(chatId);
    await database.addChat(chat);
  }
}
