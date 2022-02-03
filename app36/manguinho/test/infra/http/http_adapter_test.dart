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

    return response.body.isNotEmpty ? jsonDecode(response.body) : {};
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
    const anyBodyResponse = '{"any_key_body":"any_value_body"}';
    When mockRequest() => when(() => client.post(Uri.parse(url), headers: any(named: 'headers')));

    void mockResponse(int statusCode, {String bodyResponse = anyBodyResponse}) {
      mockRequest().thenAnswer((_) async => Response(bodyResponse, 200));
    }

    test('should call post with correct values', () async {
      final headersRequest = {'content-type': 'application/json', 'accept': 'application/json'};
      final bodyRequest = '{"any_key_request":"any_value_request"}';
      when(() => client.post(Uri.parse(url), headers: headersRequest, body: bodyRequest)).thenAnswer((_) async => Response(anyBodyResponse, 200));

      await sut.request(url: url, method: 'post', body: {'any_key_request': 'any_value_request'});

      verify(() => client.post(Uri.parse(url), headers: headersRequest, body: bodyRequest)).called(1);
    });

    test('should call post without body', () async {
      mockResponse(200);

      await sut.request(url: url, method: 'post');

      verify(() => client.post(Uri.parse(url), headers: any(named: 'headers'))).called(1);
    });

    test('should return data when post returns 200', () async {
      mockResponse(200);

      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key_body': 'any_value_body'});
    });

    test('should return {} when post returns 200 with no data', () async {
      mockResponse(200, bodyResponse: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, {});
    });
  });
}

class ClientSpy extends Mock implements Client {}
