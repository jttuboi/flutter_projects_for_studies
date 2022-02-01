import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manguinho/data/data.dart';
import 'package:manguinho/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

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
    var params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
    when(() => httpClient.request(url: url, method: 'post', body: params.toJson())).thenAnswer((_) => Future.value());

    await sut.auth(params);

    verify(() => httpClient.request(url: url, method: 'post', body: params.toJson())).called(1);
  });
}

class HttpClientSpy extends Mock implements HttpClient {}
