// ignore_for_file: prefer_final_locals, avoid_print, unnecessary_lambdas

import 'dart:async';

import '../fake/connection.dart';
import '../fake/feed.dart';
import '../fake/rethinkdb.dart';
import '../models/typing_event.dart';
import '../models/user.dart';
import 'typing_notification_service_interface.dart';

class TypingNotificationService implements ITypingNotificationService {
  TypingNotificationService(this.r, this._connection);

  final Connection _connection;
  final Rethinkdb r;

  StreamSubscription? _changeFeed;
  final _controller = StreamController<TypingEvent>.broadcast();

  @override
  Future<bool> send({required TypingEvent event, required User to}) async {
    if (!to.active) return false;

    Map record = await r.table('typing_events').insert(event.toMap(), {'conflict': 'update'}).run(_connection);
    return record['inserted'] == 1;
  }

  @override
  Stream<TypingEvent> subscribe(User user, List<String> usersIds) {
    // cria uma conexão com quem quiser subscrever, passando o usuário
    _startReceivingTypingEvents(user, usersIds);
    return _controller.stream;
  }

  @override
  Future<void> dispose() async {
    await _changeFeed?.cancel();
    await _controller.close();
  }

  void _startReceivingTypingEvents(User user, List<String> usersIds) {
    // cria uma subscrição
    _changeFeed = r
        .table('typing_events')
        .filter((event) {
          return event('to').eq(user.id).and(r.expr(usersIds).contains(event('from')));
        })
        .changes({'include_initial': true})
        .run(_connection)
        .asStream()
        .cast<Feed>()
        .listen((event) {
          event
              .forEach((feedData) {
                var data = feedData['new_val'];
                if (data == null) return null;

                // converte em message
                final typing = _eventFromFeed(data);

                // se existe mensagem, então envia para quem estiver subscrito
                _controller.sink.add(typing);

                // deleta as mensagens já enviadas
                _removeEvent(typing);
              })
              .catchError((error) => print(error))
              .onError((error, stackTrace) => print(error));
        });
  }

  TypingEvent _eventFromFeed(dynamic feedData) {
    return TypingEvent.fromMap(feedData['new_val'])!;
  }

  void _removeEvent(TypingEvent event) {
    r.table('typing_events').get(event.id).delete({'return_changes': false}).run(_connection);
  }
}
