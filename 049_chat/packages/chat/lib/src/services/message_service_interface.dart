import 'dart:async';

import '../entities/message.dart';
import '../entities/user.dart';

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
