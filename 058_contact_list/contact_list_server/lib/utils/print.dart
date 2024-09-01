import 'dart:developer';

import 'package:shelf/shelf.dart';

import '../../../database/database.dart';

Future<void> printRequest(Request request) async {
  log('=== request =====');
  log(request.requestedUri.toString());
  log(request.method);
  log(request.headers.toString());
  log(await request.readAsString());
}

Future<void> printResponse(Response response) async {
  log('=== response =====');
  log(response.statusCode.toString());
  log(response.headers.toString());
  log(await response.readAsString());
}

void printContacts() {
  print('[');
  for (final contact in contactsDB) {
    print(contact.toShortString());
  }
  print(']');
}
