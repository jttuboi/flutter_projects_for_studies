// ignore_for_file: unnecessary_lambdas, prefer_final_locals, omit_local_variable_types

import '../fake/connection.dart';
import '../fake/rethinkdb.dart';
import '../models/user.dart';
import 'user_service_interface.dart';

class UserService implements IUserService {
  const UserService(this.r, this._connection);

  final Connection _connection;
  final Rethinkdb r;

  @override
  Future<List<User>> online() async {
    // recupera todos usuários ativos
    final users = await r.table('users').filter({'active': true}).run(_connection);

    // retorna a lista
    final userList = await users.toList();
    return userList.map((item) => User.fromMap(item)).toList();
  }

  @override
  Future<User> connect(User user) async {
    final data = user.toMap();
    if (user.id != null) data['id'] = user.id;

    // salva o usuário na base de dados
    final result = await r.table('users').insert(data, {
      'conflict': 'update',
      'return_changes': true,
    }).run(_connection);

    // retorna o usuário salvo
    return User.fromMap(result['changes'].first['new_val'])!;
  }

  @override
  Future<void> disconnect(User user) async {
    // atualiza o usuário da base de dados, deixando como desativado (e atualizando a última vista)
    await r.table('users').update({
      'id': user.id,
      'active': false,
      'last_seen': DateTime.now(),
    }).run(_connection);

    // fecha conexão
    _connection.close();
  }
}
