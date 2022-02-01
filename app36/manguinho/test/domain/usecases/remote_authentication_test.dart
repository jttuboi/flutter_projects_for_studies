import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class RemoteAuthentication {
  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  final HttpClient httpClient;
  final String url;

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'get');
  }
}

abstract class HttpClient {
  Future<void> request({required String url, required String method});
}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('should call HttpClient with correct values', () async {
    when(() => httpClient.request(url: url, method: 'get')).thenAnswer((_) => Future.value());

    await sut.auth();

    verify(() => httpClient.request(url: url, method: 'get')).called(1);
  });
}

class HttpClientSpy extends Mock implements HttpClient {}
