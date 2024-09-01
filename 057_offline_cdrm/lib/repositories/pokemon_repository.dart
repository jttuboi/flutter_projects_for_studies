import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';

import '../exceptions/offline_exception.dart';
import '../services/http_client_service.dart';
import '../services/key_value_database_service.dart';

// https://pokeapi.co/docs/v2#pokemon
class PokemonRepository {
  PokemonRepository({IHttpClientService? httpClientService, IKeyValueDatabaseService? keyValueDatabaseService})
      : _httpClientService = httpClientService ?? Modular.get<IHttpClientService>(),
        _keyValueDatabaseService = keyValueDatabaseService ?? Modular.get<IKeyValueDatabaseService>();

  final IHttpClientService _httpClientService;
  final IKeyValueDatabaseService _keyValueDatabaseService;

  Stream<List<String>> getAll() async* {
    print('QQQQQQQQQ');
    // https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20
    // response.data = {
    //   "count": 1281,
    //   "next": "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20",
    //   "previous": null,
    //   "results": [
    //     {
    //       "name": "bulbasaur",
    //       "url": "https://pokeapi.co/api/v2/pokemon/1/"
    //     },
    //     ...
    //   ]
    // }
    try {
      final data = await _keyValueDatabaseService.getString('pokemons');
      if (data.isEmpty) {
        yield [];
      }

      final response = await _httpClientService.get('https://pokeapi.co/api/v2/pokemon/');
      final results = response.data['results'];

      final list = <String>[];
      for (final result in results) {
        list.add(result['name']);
      }
      yield list;
    } on OfflineException {
      await Future.delayed(const Duration(seconds: 1));
      yield jsonDecode() ?? [];
    }
  }
}
