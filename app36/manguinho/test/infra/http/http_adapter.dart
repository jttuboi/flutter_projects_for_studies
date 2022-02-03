import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class HttpAdapter {
  HttpAdapter(this.client);

  final Client client;

  Future<void> request({required String url, required String method, Map body = const {}}) async {
    await client.post(Uri.parse(url));
  }
}

void main() {
  group('post', () {
    test('should call post with correct values', () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();
      when(() => client.post(Uri.parse(url))).thenAnswer((_) => Future.value(Response('', 200)));

      await sut.request(url: url, method: 'post');

      verify(() => client.post(Uri.parse(url))).called(1);
    });
  });
}

class ClientSpy extends Mock implements Client {}
