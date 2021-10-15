import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textFieldController = TextEditingController();

  var _isLoading = false;
  String? _error;
  var _cepResult = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search city by CEP')),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          children: [
            TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(labelText: 'CEP', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _searchCep(_textFieldController.text),
              child: const Text('Search'),
            ),
            const SizedBox(height: 10),
            if (_isLoading) const Expanded(child: Center(child: CircularProgressIndicator())),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            if (!_isLoading && _cepResult.isNotEmpty) Text('City: ${_cepResult['localidade']}'),
          ],
        ),
      ),
    );
  }

  Future<void> _searchCep(String cep) async {
    try {
      _cepResult = {};
      _error = null;
      setState(() => _isLoading = true);
      final response = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      setState(() => _cepResult = response.data);
    } catch (e) {
      _error = 'Erro na pesquisa';
    }
    setState(() => _isLoading = false);
  }
}
