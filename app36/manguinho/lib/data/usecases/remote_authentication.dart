import '../../domain/usecases/usecases.dart';

import '../http/http.dart';

class RemoteAuthentication {
  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  final HttpClient httpClient;
  final String url;

  Future<void> auth(AuthenticationParams params) async {
    await httpClient.request(url: url, method: 'post', body: params.toJson());
  }
}
