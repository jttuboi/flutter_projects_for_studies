import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:uno/uno.dart';

const url = 'https://jsonplaceholder.typicode.com/todos';

void main(List<String> arguments) async {
  httpClient();
}

void unoPackage() async {
  final uno = Uno();
  final response = await uno(url: url, method: 'get');

  final json = response.data;
  print(json);
}

void dioPackage() async {
  final response = await Dio().get(url);

  final json = response.data;
  print(json);
}

void httpPackage() async {
  final response = await http.get(Uri.parse(url));

  final body = response.body;
  //print(body);

  final json = jsonDecode(body);
  print(json);
}

void httpClient() async {
  final client = HttpClient();

  final request = await client.openUrl('get', Uri.parse(url));
  request.headers.set('content-type', 'application/json');

  final response = await request.close();

  final list = <String>[];
  await for (var data in response) {
    final string = utf8.decode(data);
    list.add(string);
  }

  final body = list.join();
  print(body);

  final json = jsonDecode(body);
  //print(json);
}
