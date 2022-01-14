import 'user.dart';

final _fakeDatabase = {
  'users': [
    {'id': '12345', 'username': 'jtt', 'password': '123'},
    {'id': '12346', 'username': 'ccd', 'password': '123'},
    {'id': '12347', 'username': 'fsr', 'password': '123'},
  ]
};

bool hasUser(String username, {String password = ''}) {
  if (password.isEmpty) {
    return _fakeDatabase['users']!.any((user) => user['username']! == username);
  }
  return _fakeDatabase['users']!.any(
      (user) => user['username']! == username && user['password']! == password);
}

User searchUser(String username, String password) {
  for (final user in _fakeDatabase['users']!) {
    if (user['username'] == username && user['password'] == password) {
      return User(
        id: user['id']!,
        username: user['username']!,
        password: user['password']!,
      );
    }
  }
  return User.empty;
}

User addUser(String username, String password) {
  _fakeDatabase['users']!.add({
    'id': _getBurroId(),
    'username': username,
    'password': password,
  });

  return User(
    id: _fakeDatabase['users']!.last['id']!,
    username: _fakeDatabase['users']!.last['username']!,
    password: _fakeDatabase['users']!.last['password']!,
  );
}

void printDatabase() {
  print('=================');
  print('- users ---------');
  for (final user in _fakeDatabase['users']!) {
    print(
        'id: ${user['id']!}, username: ${user['username']!}, password: ${user['password']!}');
  }
  print('=================');
}

String _getBurroId() {
  return (int.parse(_fakeDatabase['users']!.last['id']!) + 1).toString();
}
