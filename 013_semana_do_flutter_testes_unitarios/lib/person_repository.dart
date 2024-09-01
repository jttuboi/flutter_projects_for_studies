import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:semana_do_flutter_testes_unitarios/person.dart';

class PersonRepository {
  PersonRepository(this.client);

  final http.Client client;

  Future<List<Person>> getPerson() async {
    final response = await client.get(
        Uri.parse('https://60f6ee22eb48e700179197f7.mockapi.io/api/v1/person'));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((e) => Person.fromMap(e)).toList();
    } else {
      throw Exception('Erro na internet');
    }
  }
}
