import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:manguinho/data/data.dart';
import 'package:manguinho/infra/http/http.dart';
import 'package:mocktail/mocktail.dart';

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
      mockRequest().thenAnswer((_) async => Response(bodyResponse, statusCode));
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

    test('should return empty map when post returns 200 with no data', () async {
      mockResponse(200, bodyResponse: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, {});
    });

    test('should return empty map when post returns 204 with data', () async {
      mockResponse(204);

      final response = await sut.request(url: url, method: 'post');

      expect(response, {});
    });

    test('should return empty map when post returns 204 with no data', () async {
      mockResponse(204, bodyResponse: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, {});
    });

    test('should return BadRequestError when post returns 400', () async {
      mockResponse(400);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('should return BadRequestError when post returns 400', () async {
      mockResponse(400, bodyResponse: '');

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

    test('should return UnauthorizedError when post returns 401', () async {
      mockResponse(401);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.unauthorized));
    });

    test('should return ForbiddenError when post returns 403', () async {
      mockResponse(403);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.forbidden));
    });

    test('should return NotFoundError when post returns 404', () async {
      mockResponse(404);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.notFound));
    });

    test('should return ServerError when post returns 500', () async {
      mockResponse(500);

      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });
  });
}

class ClientSpy extends Mock implements Client {}
