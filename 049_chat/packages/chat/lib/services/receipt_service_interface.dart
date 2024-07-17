import 'dart:async';

import '../models/receipt.dart';
import '../models/user.dart';

abstract class IReceiptService {
  const IReceiptService();

  /// Envia mensagem para quem estiver subscrito no serviço. Retorna true se enviado com sucesso
  ///
  Future<bool> send(Receipt receipt);

  /// Subscreve no serviço passando o usuário
  ///
  Stream<Receipt> receipts(User user);

  /// Desconecta
  ///
  Future<void> dispose();
}
