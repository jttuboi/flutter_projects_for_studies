import '../entities/user.dart';

abstract class IUserService {
  const IUserService();

  /// Retorna todos usuários online
  ///
  Future<List<User>> online();

  /// Conecta o usuário no servidor
  ///
  Future<User> connect(User user);

  /// Desconecta o usuário do servidor
  ///
  Future<void> disconnect(User user);
}
