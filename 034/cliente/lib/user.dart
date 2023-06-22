class User {
  User({
    required this.authenticated,
    required this.expiration,
    required this.token,
    required this.message,
  });

  final bool authenticated;
  final String expiration;
  final String token;
  final String message;

  factory User.empty() => User(authenticated: false, expiration: '', token: '', message: '');

  Map<String, dynamic> toMap() {
    return {
      'authenticated': authenticated,
      'expiration': expiration,
      'token': token,
      'message': message,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      authenticated: map['authenticated'] ?? false,
      expiration: map['expiration'] ?? '',
      token: map['token'] ?? '',
      message: map['message'] ?? '',
    );
  }
}
