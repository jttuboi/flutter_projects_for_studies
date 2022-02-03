import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:manguinho/data/data.dart';
import 'package:mocktail/mocktail.dart';

class HttpAdapter implements HttpClient {
  HttpAdapter(this.client);

  final Client client;

  Future<Map> request({required String url, required String method, Map body = const {}}) async {
    final headers = {'content-type': 'application/json', 'accept': 'application/json'};
    final jsonBody = body.isNotEmpty ? jsonEncode(body) : null;

    var response = await client.post(Uri.parse(url), headers: headers, body: jsonBody);

    return jsonDecode(response.body);
  }
}

void main() {
  late HttpAdapter sut;
  late ClientSpy client;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('post', () {
    test('should call post with correct values', () async {
      when(() => client.post(
            Uri.parse(url),
            headers: {'content-type': 'application/json', 'accept': 'application/json'},
            body: '{"any_key":"any_value"}',
          )).thenAnswer((_) => Future.value(Response('{"any_key":"any_value"}', 200)));

      await sut.request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(() => client.post(
            Uri.parse(url),
            headers: {'content-type': 'application/json', 'accept': 'application/json'},
            body: '{"any_key":"any_value"}',
          )).called(1);
    });

    test('should call post without body', () async {
      when(() => client.post(Uri.parse(url), headers: any(named: 'headers')))
          .thenAnswer((_) => Future.value(Response('{"any_key":"any_value"}', 200)));

      await sut.request(url: url, method: 'post');

      verify(() => client.post(Uri.parse(url), headers: any(named: 'headers'))).called(1);
    });

    test('should return data when post returns 200', () async {
      when(() => client.post(Uri.parse(url), headers: any(named: 'headers')))
          .thenAnswer((_) => Future.value(Response('{"any_key":"any_value"}', 200)));

      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });
  });
}

class ClientSpy extends Mock implements Client {}
