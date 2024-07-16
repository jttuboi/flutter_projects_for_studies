// // ignore_for_file: unnecessary_lambdas

// import '../models/user.dart';
// import 'user_service_interface.dart';

// class UserService implements IUserService {
//   const UserService(this.r, this._connection);

//   final Connection _connection;
//   final Rethinkdb r;

//   @override
//   Future<User> connect(User user) async {
//     final data = user.toMap();
//     if (user.id != null) data['id'] = user.id;

//     final result = await r.table('users').insert(data, {
//       'conflict': 'update',
//       'return_changes': true,
//     }).run(_connection);

//     return User.fromMap(result['changes'].first['new_val']);
//   }

//   @override
//   Future<void> disconnect(User user) async {
//     await r.table('users').update({
//       'id': user.id,
//       'active': false,
//       'last_seen': DateTime.now(),
//     }).run(_connection);

//     _connection.close();
//   }

//   @override
//   Future<List<User>> online() async {
//     Cursor users = await r.table('users').filter({'active': true}).run(_connection);
//     final userList = await users.toList();
//     return userList.map((item) => User.fromMap(item)).toList();
//   }
// }
