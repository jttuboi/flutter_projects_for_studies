import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams {
  AuthenticationParams({
    required this.email,
    required this.secret,
  });

  final String email;
  final String secret;
}
