import '../models/user.dart';

abstract class IUserService {
  const IUserService();

  Future<List<User>> online();

  Future<User> connect(User user);

  Future<void> disconnect(User user);
}
