import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manguinho/data/data.dart';
import 'package:manguinho/domain/helpers/helpers.dart';
import 'package:manguinho/domain/usecases/usecases.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;
  late AuthenticationParams params;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(email: faker.internet.email(), secret: faker.internet.password());
  });

  test('should call HttpClient with correct values', () async {
    var body = RemoteAuthenticationParams.fromDomain(params).toJson();
    var httpResponse = {'accessToken': faker.guid.guid(), 'name': faker.person.name()};
    when(() => httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')))
        .thenAnswer((_) async => httpResponse);

    await sut.auth(params);

    verify(() => httpClient.request(url: url, method: 'post', body: body)).called(1);
  });

  test('should throw UnexpectedError when HttpClient returns 400', () async {
    when(() => httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body'))).thenThrow(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw UnexpectedError when HttpClient returns 404', () async {
    when(() => httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body'))).thenThrow(HttpError.notFound);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw UnexpectedError when HttpClient returns 500', () async {
    when(() => httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body'))).thenThrow(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw InvalidCredentialsError when HttpClient returns 401', () async {
    when(() => httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body'))).thenThrow(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('should return an account when HttpClient returns 200', () async {
    final accessToken = faker.guid.guid();
    var httpResponse = {'accessToken': accessToken, 'name': faker.person.name()};
    when(() => httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')))
        .thenAnswer((_) async => httpResponse);

    final account = await sut.auth(params);

    expect(account.token, accessToken);
  });

  test('should throw UnexpectedError when HttpClient returns 200 with invalid data', () async {
    when(() => httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')))
        .thenAnswer((_) async => {'invalid_key': 'invalid_value'});

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}

class HttpClientSpy extends Mock implements HttpClient {}
