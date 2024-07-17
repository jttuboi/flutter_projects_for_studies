// ignore_for_file: unused_local_variable, omit_local_variable_types, prefer_final_locals

import 'package:chat/src/entities/receipt.dart';
import 'package:chat/src/entities/user.dart';
import 'package:chat/src/fake/connection.dart';
import 'package:chat/src/fake/rethinkdb.dart';
import 'package:chat/src/services/receipt_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  Rethinkdb r = Rethinkdb();
  late Connection connection;
  late ReceiptService sut;

  setUp(() async {
    connection = await r.connect(host: '127.0.0.1', port: 28015);
    await createDb(r, connection);
    sut = ReceiptService(r, connection);
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

  test('sent receipt successfully', () async {
    Receipt receipt = Receipt(
      id: '',
      recipient: '444',
      messageId: '1234',
      status: ReceiptStatus.delivered,
      timestamp: DateTime.now(),
    );

    final result = await sut.send(receipt);
    expect(result, true);
  });

  test('successfully subscribe and receive receipts', () async {
    sut.receipts(user).listen(expectAsync1((receipt) {
          expect(receipt.recipient, user.id);
        }, count: 2));

    Receipt receipt = Receipt(
      id: '',
      recipient: user.id ?? '',
      messageId: '1234',
      status: ReceiptStatus.delivered,
      timestamp: DateTime.now(),
    );

    Receipt anotherReceipt = Receipt(
      id: '',
      recipient: user.id ?? '',
      messageId: '1234',
      status: ReceiptStatus.read,
      timestamp: DateTime.now(),
    );

    await sut.send(receipt);
    await sut.send(anotherReceipt);
  });
}
