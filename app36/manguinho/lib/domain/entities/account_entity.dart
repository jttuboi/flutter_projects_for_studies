class AccountEntity {
  AccountEntity(this.token);

  final String token;

  factory AccountEntity.fromMap(Map map) {
    return AccountEntity(
      map['accessToken'],
    );
  }
}
