import 'dart:convert';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import 'fake_database.dart';

// https://www.devmedia.com.br/web-services-restful-como-adicionar-seguranca-com-jwt/38990
// https://dev.to/carminezacc/user-authentication-jwt-authorization-with-flutter-and-node-176l
// https://www.wellingtonjhn.com/posts/entendendo-tokens-jwt/

// Sobre server em dart
// https://medium.com/flutter-community/routing-http-requests-in-a-dart-server-889c0a0475b0

// quando dá pau, ele deixa em aberto o acesso ao socket. para matar, basta utilizar o comando abaixo.
// taskkill /F /IM dart.exe (Windows)
// killall -9 dart (Linux, Mac?)

const serverUrl = 'http://localhost:4040';
const secretServerKey = 'm yincredibl y(!!1!11!)<SECRET>)Key!';

Future<Map<String, dynamic>> _extractUserData(HttpRequest request) async {
  return json.decode(await utf8.decoder.bind(request).join())
      as Map<String, dynamic>;
}

void main(List<String> arguments) async {
  // http://localhost:4040
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4040);

  server.listen((HttpRequest request) async {
    if (request.method == 'POST' && request.uri.path == '/login') {
      print('=================');
      print(' /login ');
      print('=================');
      await _login(request);
    } else if (request.method == 'POST' && request.uri.path == '/signup') {
      print('=================');
      print(' /signup ');
      print('=================');
      await _signup(request);
    } else if (request.method == 'GET' && request.uri.path == '/data') {
      print('=================');
      print(' /data ');
      print('=================');
      _getData(request);
    }

    printDatabase();

    await request.response.close();
  });
}

Future<void> _login(HttpRequest request) async {
  var userData = await _extractUserData(request);
  var username = userData['username']!;
  var password = userData['password']!; // recomendado criptografar a senha

  print(username);
  print(password);

  if (hasUser(username, password: password)) {
    final jwt = JWT({
      'name': 'Jão Pé de Feijão',
      'sub': username, // 'Eu, o id do usuario.',
      'iss':
          'Eu, o server. Aqui deve ser um link ou algo que mostre quem é o emissor do token.',
    });

    String token = jwt.sign(
      SecretKey(secretServerKey),
      expiresIn: const Duration(minutes: 1),
    );

    print('Login success. Token: $token');
    request.response.statusCode = HttpStatus.ok; //200
    request.response.statusCode = 200;
    request.response.write(token);
  } else {
    print('Login failed.');
    request.response.statusCode = HttpStatus.unauthorized; //401
    request.response.write('Username and/or password does t exist.');
  }
}

Future<void> _signup(HttpRequest request) async {
  var userData = await _extractUserData(request);
  var username = userData['username']!;
  var password = userData['password']!; // recomendado criptografar a senha

  if (hasUser(username)) {
    print('Can t create user $username because already exists.');
    request.response.statusCode = HttpStatus.conflict; //409
    request.response.write('An user with that username already exists.');
  } else {
    addUser(username, password);
    print('$username created.');
    request.response.statusCode = HttpStatus.created; //201
    request.response.write('Success.');
  }
}

void _getData(HttpRequest request) {
  String token = _extractToken(request);
  if (token.isNotEmpty) {
    try {
      final jwt = JWT.verify(token, SecretKey(secretServerKey));
      print('Payload: ${jwt.payload}');
      request.response.statusCode = HttpStatus.ok; //200
      request.response.write('Data from server');
    } on JWTExpiredError {
      print('Jwt expired');
      request.response.statusCode = HttpStatus.unauthorized; //401
      request.response.write('Token expired.');
    } on JWTError catch (e) {
      print(e.message);
      print('Signature is invalid. Token: $token');
      request.response.statusCode = HttpStatus.unauthorized; //401
      request.response.write('Invalid token. Are you trying to hacking me?');
    }
  } else {
    request.response.statusCode = HttpStatus.unauthorized; //401
    request.response.write('No token founded.');
  }
}

String _extractToken(HttpRequest request) {
  if (request.headers['Authorization'] == null) {
    return '';
  }
  return request.headers['Authorization']![0];
}
