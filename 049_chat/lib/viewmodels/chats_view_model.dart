import 'package:chat/chat.dart';

import '../entities/local_message.dart';
import 'base_view_model.dart';

class ChatsViewModel extends BaseViewModel {
  ChatsViewModel(super.database);

  Future<void> receivedMessage(Message message) async {
    final localMessage = LocalMessage(id: '1', chatId: message.from, message: message, receipt: ReceiptStatus.delivered);
    await addMessage(localMessage);
  }
}
