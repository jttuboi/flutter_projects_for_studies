import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

// https://jwt.io/
// https://pub.dev/packages/crypto

// quando dá pau, ele deixa em aberto o acesso ao socket. para matar, basta utilizar o comando abaixo.
// taskkill /F /IM dart.exe (Windows)
// killall -9 dart (Linux, Mac?)

// aulas sobre JWT em flutter
// https://www.youtube.com/watch?v=BCbO4iRNNsM (sobre o JWT - entendendo JWT e montando simples servidor em dart)

// secret sempre fica no servidor
const secret = 'chave_secreta_que_tem_no_servidor';

void main(List<String> arguments) async {
  // http://localhost:4040
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4040);

  server.listen((request) async {
    if (request.uri.path == '/login') {
      // recebe os dados do client
      // entra na base de dados se é o usuário mesmo
      // gera o token e retorna para o client
      request.response.write(_generateToken());
    } else if (request.uri.path == '/teste') {
      if (_checkToken(request)) {
        request.response.write('Seja bem vindo');
      } else {
        request.response.write('acesso negado');
      }
    } else {
      request.response.statusCode = 404;
      request.response.write('pagina nao encontrada');
    }

    await request.response.close();
  });
}

bool _checkToken(HttpRequest request) {
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

int get _currentTime => DateTime.now().millisecondsSinceEpoch;

String _generateToken() {
  // dados obrigatórios para reconhecer o uso de JWT
  var header = {
    'alg': 'HS256',
    'typ': 'JWT',
  };
  var header64 = base64Encode(jsonEncode(header).codeUnits);

  // dados de login, ex: id do user, expiração do token, roles, etc...
  // é IMPORTANTE NÃO passar dados sensíveis, pois essa parte não é segura, em outras palavras, esse payload é visível
  var payload = {
    'sub': 1,
    'name': 'jtt',
    'exp': DateTime.now().millisecondsSinceEpoch + 60000 // 1 min
  };
  var payload64 = base64Encode(jsonEncode(payload).codeUnits);

  // criptografa o secret
  var hmac = Hmac(sha256, secret.codeUnits);
  var digest = hmac.convert('$header64.$payload64'.codeUnits);
  var signature = base64Encode(digest.bytes);

  // token gerado
  return '$header64.$payload64.$signature';
}
