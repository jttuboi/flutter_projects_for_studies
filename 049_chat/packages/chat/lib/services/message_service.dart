// ignore_for_file: prefer_final_locals, unnecessary_lambdas

import 'dart:async';

import '../fake/connection.dart';
import '../fake/feed.dart';
import '../fake/rethinkdb.dart';
import '../models/message.dart';
import '../models/user.dart';
import 'encryption_service_interface.dart';
import 'message_service_interface.dart';

class MessageService implements IMessageService {
  MessageService(this.r, this._connection, this._encryptionService);

  final Connection _connection;
  final Rethinkdb r;
  final IEncryptionService _encryptionService;

  StreamSubscription? _changeFeed;
  final _controller = StreamController<Message>.broadcast();

  @override
  Future<bool> send(Message message) async {
    // converte em map
    var data = message.toMap();
    data['contents'] = _encryptionService.encrypt(message.contents);

    // adiciona a msg na base de dados
    Map record = await r.table('messages').insert(data).run(_connection);

    // retorna true se foi inserido
    return record['inserted'] == 1;
  }

  @override
  Stream<Message> messages({required User activeUser}) {
    // cria uma conexão com quem quiser subscrever, passando o usuário
    _startReceivingMessages(activeUser);
    return _controller.stream;
  }

  @override
  Future<void> dispose() async {
    await _changeFeed?.cancel();
    await _controller.close();
  }

  void _startReceivingMessages(User user) {
    // cria uma subscrição
    _changeFeed = r
        .table('messages')
        .filter({
          'to': user.id,
        })
        .changes({
          'include_initial': true,
        })
        .run(_connection)
        .asStream()
        .cast<Feed>()
        .listen((event) {
          event
              .forEach((feedData) {
                var data = feedData['new_val'];
                if (data == null) return null;

                // converte em message
                data['contents'] = _encryptionService.decrypt(data['contents']);
                final message = Message.fromMap(data)!;

                // se existe mensagem, então envia para quem estiver subscrito
                _controller.sink.add(message);

                // deleta as mensagens já enviadas
                _removeDeliveredMessage(message);
              })
              .catchError((error) => print(error))
              .onError((error, stackTrace) => print(error));
        });
  }

  void _removeDeliveredMessage(Message message) {
    r.table('messages').get(message.id).delete({'return_changes': false}).run(_connection);
  }
}
