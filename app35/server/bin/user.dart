class User {
  static const User empty = User(id: '', username: '', password: '');

  const User({
    required this.id,
    required this.username,
    required this.password,
  });

  final String id;
  final String username;
  final String password;
}
