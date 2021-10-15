import 'dart:async';

import 'package:dio/dio.dart';

class SearchCepBloc {
  // o String é o CEP passado da page para cá
  final _streamController = StreamController<String>.broadcast();
  Sink<String> get searchCep => _streamController.sink;
  Stream<Map> get cepResult => _streamController.stream.asyncMap(_searchCep);

  Future<Map> _searchCep(String cep) async {
    try {
      final response = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      return response.data;
    } catch (e) {
      throw Exception('Erro na pesquisa');
    }
  }

  void dispose() {
    _streamController.close();
  }
}
