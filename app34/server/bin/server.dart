import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

import 'todo.dart';

// https://jwt.io/
// https://pub.dev/packages/crypto

// quando dá pau, ele deixa em aberto o acesso ao socket. para matar, basta utilizar o comando abaixo.
// taskkill /F /IM dart.exe (Windows)
// killall -9 dart (Linux, Mac?)

// secret sempre fica no servidor
const secret = 'MINHA_CHAVE_SUPER_HIPER_MEGA_ULTRA_POWER_SECRETA';

void main(List<String> arguments) async {
  // http://localhost:4040
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4040);

  server.listen((HttpRequest request) async {
    if (request.method == 'POST' && request.uri.path == '/api/login') {
      await _login(request);
    } else if (request.method == 'GET' && request.uri.path == '/api/todos') {
      await _fetchTodos(request);
    }

    await request.response.close();
  });
}

Future<void> _login(HttpRequest request) async {
  var userData = await _extractUserData(request);

  if (_hasValidData(userData)) {
    if (_fakeCheckValidUser(userData)) {
      // nesse momento já deve ter pesquisado pelo usuario
      // e pego o userId (caso necessario)
      // no exemplo, o userId == 1

      request.response.write(jsonEncode({
        'authenticated': true,
        'token': _generateToken(1, userData['username']),
        'message': 'OK',
      }));
    } else {
      request.response.statusCode = HttpStatus.unauthorized;
      request.response.write(jsonEncode({
        'message': 'Login Inválido',
      }));
    }
  } else {
    request.response.statusCode = HttpStatus.unauthorized;
    request.response.write(jsonEncode({
      'message': 'Dados Inválidos',
    }));
  }
}

Future<Map<String, dynamic>> _extractUserData(HttpRequest request) async {
  return jsonDecode(await utf8.decoder.bind(request).join()) as Map<String, dynamic>;
}

bool _hasValidData(Map<String, dynamic> userData) =>
    userData.containsKey('username') &&
    userData.containsKey('password') &&
    userData.containsKey('email') &&
    userData['username'] != null &&
    userData['password'] != null &&
    userData['email'] != null;

bool _fakeCheckValidUser(Map<String, dynamic> userData) =>
    userData['username'] == 'user_a' && userData['password'] == '123123' && userData['email'] == 'a@a.com';

Future<void> _fetchTodos(HttpRequest request) async {
  if (_checkToken(request)) {
    // envia lista de todos
    request.response.write(jsonEncode(getTodos.map((e) => e.toMap()).toList()));
  } else {
    // 401
    request.response.statusCode = HttpStatus.unauthorized;
  }
}

List<Todo> get getTodos => [
      Todo(title: 'titulo 1', message: 'mensagem 1', completed: true),
      Todo(title: 'titulo 2', message: 'mensagem 2', completed: false),
      Todo(title: 'titulo 3', message: 'mensagem 3', completed: true),
      Todo(title: 'titulo 4', message: 'mensagem 4', completed: false),
    ];

bool _checkToken(HttpRequest request) {
  print(request.headers);
  if (request.headers['Authorization'] == null) {
    return false;
  }

  var token = request.headers['Authorization']![0].split(' ')[1];
  var jwtToken = token.split('.');

  var header64 = jwtToken[0];
  var payload64 = jwtToken[1];
  var signature64 = jwtToken[2];

  var hmac = Hmac(sha256, secret.codeUnits);
  var digest = hmac.convert('$header64.$payload64'.codeUnits);
  var signatureGlobal = base64Encode(digest.bytes);

  if (signature64 != signatureGlobal) {
    return false;
  }

  var payload = jsonDecode(utf8.decode(base64Decode(payload64)));

  if (_currentTime > payload['exp']) {
    return false;
  }

  return true;
}

String _generateToken(int userId, String username) {
  // dados obrigatórios para reconhecer o uso de JWT
  var header = {
    'alg': 'HS256',
    'typ': 'JWT',
  };
  var header64 = base64Encode(jsonEncode(header).codeUnits);

  // dados de login, ex: id do user, expiração do token, roles, etc...
  // é IMPORTANTE NÃO passar dados sensíveis, pois essa parte não é segura, em outras palavras, esse payload é visível
  var payload = {
    'sub': userId.toString(),
    'name': username,
    'exp': _currentTime + 60000 // 1 min
  };
  var payload64 = base64Encode(jsonEncode(payload).codeUnits);

  // criptografa o secret
  var hmac = Hmac(sha256, secret.codeUnits);
  var digest = hmac.convert('$header64.$payload64'.codeUnits);
  var signature = base64Encode(digest.bytes);

  // token gerado
  return '$header64.$payload64.$signature';
}

int get _currentTime => DateTime.now().millisecondsSinceEpoch;
