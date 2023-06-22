import 'package:manguinho/data/data.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

class RemoteAuthentication implements Authentication {
  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  final HttpClient httpClient;
  final String url;

  Future<AccountEntity> auth(AuthenticationParams params) async {
    var body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      final httpResponse = await httpClient.request(url: url, method: 'post', body: body);
      return RemoteAccountModel.fromMap(httpResponse).toEntity();
    } on HttpError catch (e) {
      if (e == HttpError.unauthorized) {
        throw DomainError.invalidCredentials;
      }
      throw DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  RemoteAuthenticationParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) {
    return RemoteAuthenticationParams(email: params.email, password: params.secret);
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
