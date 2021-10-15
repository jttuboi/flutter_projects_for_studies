import 'package:flutter/material.dart';
import 'package:search_city_by_cep/search_cep_bloc.dart';

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
    _searchCepBloc.dispose();
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
              onPressed: () => _searchCepBloc.searchCep.add(_textFieldController.text),
              child: const Text('Search'),
            ),
            const SizedBox(height: 10),
            StreamBuilder<SearchCepState>(
              stream: _searchCepBloc.cepResult,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }

                final state = snapshot.data;
                if (state is SearchCepError) {
                  return Text(state.message, style: const TextStyle(color: Colors.red));
                }

                if (state is SearchCepLoading) {
                  return const Expanded(child: Center(child: CircularProgressIndicator()));
                }

                return Text('City: ${(state as SearchCepSuccess).data['localidade']}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
