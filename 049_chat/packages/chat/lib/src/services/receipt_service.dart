// ignore_for_file: prefer_final_locals, unnecessary_lambdas

import 'dart:async';

import '../entities/receipt.dart';
import '../entities/user.dart';
import '../fake/connection.dart';
import '../fake/feed.dart';
import '../fake/rethinkdb.dart';
import 'receipt_service_interface.dart';

class ReceiptService implements IReceiptService {
  ReceiptService(this.r, this._connection);

  final Connection _connection;
  final Rethinkdb r;

  StreamSubscription? _changeFeed;
  final _controller = StreamController<Receipt>.broadcast();

  @override
  Future<bool> send(Receipt receipt) async {
    // converte em map
    var data = receipt.toMap();

    // adiciona a msg na base de dados
    Map record = await r.table('messages').insert(data).run(_connection);

    // retorna true se foi inserido
    return record['inserted'] == 1;
  }

  @override
  Stream<Receipt> receipts(User user) {
    // cria uma conexão com quem quiser subscrever, passando o usuário
    _startReceivingReceipts(user);
    return _controller.stream;
  }

  @override
  Future<void> dispose() async {
    await _changeFeed?.cancel();
    await _controller.close();
  }

  void _startReceivingReceipts(User user) {
    // cria uma subscrição
    _changeFeed = r
        .table('receipts')
        .filter({
          'recipient': user.id,
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
                final receipt = Receipt.fromMap(data)!;

                // se existe mensagem, então envia para quem estiver subscrito
                _controller.sink.add(receipt);
              })
              .catchError((error) => print(error))
              .onError((error, stackTrace) => print(error));
        });
  }
}
