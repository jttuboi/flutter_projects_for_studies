import 'dart:async';

import '../models/message.dart';
import '../models/user.dart';

abstract class IMessageService {
  const IMessageService();

  /// Envia mensagem para quem estiver subscrito no serviço. Retorna true se enviado com sucesso
  ///
  Future<bool> send(Message message);

  /// Subscreve no serviço passando o usuário
  ///
  Stream<Message> messages({required User activeUser});

  /// Desconecta
  ///
  Future<void> dispose();
}
