import 'dart:developer';
import 'dart:io' as io;

import 'package:contact_list_server/utils/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) async {
  final ip = io.InternetAddress.anyIPv4; // Use any available host or container IP (usually `0.0.0.0`).

  final handler = const Pipeline().addMiddleware(logRequests()).addMiddleware(addBasePathUrl).addHandler(router);

  final port = int.parse(io.Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  log('=== Server listening on http://${server.address.host}:${server.port}');
}
