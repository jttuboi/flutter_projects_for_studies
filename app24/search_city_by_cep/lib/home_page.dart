import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_city_by_cep/search_cep_bloc.dart';
import 'package:search_city_by_cep/search_cep_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textFieldController = TextEditingController();
  final _searchCepBloc = SearchCepBloc();

  @override
  void dispose() {
    _searchCepBloc.close();
    super.dispose();
  }

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
              onPressed: () => _searchCepBloc.add(_textFieldController.text),
              child: const Text('Search'),
            ),
            const SizedBox(height: 10),
            BlocBuilder<SearchCepBloc, SearchCepState>(
              bloc: _searchCepBloc,
              builder: (context, state) {
                if (state is SearchCepError) {
                  return Text(state.message, style: const TextStyle(color: Colors.red));
                }

                if (state is SearchCepLoading) {
                  return const Expanded(child: Center(child: CircularProgressIndicator()));
                }

                state = state as SearchCepSuccess;
                return Text('City: ${state.data['localidade']}/${state.data['uf']}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
