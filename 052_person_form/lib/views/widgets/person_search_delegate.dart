import 'package:flutter/material.dart';
import 'package:person_form/models/models/person.dart';

class PersonSearchDelegate extends SearchDelegate {
  PersonSearchDelegate({required List<Person> persons})
      : _persons = persons,
        super(
          keyboardType: TextInputType.text,
          searchFieldLabel: 'Digite o nome da pessoa',
        );

  final List<Person> _persons;

  @override
  void showResults(BuildContext context) {
    close(context, query.trim());
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: const Icon(Icons.backspace),
          onPressed: () => query = '',
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_persons[index].name),
          onTap: () => close(context, _persons[index].name),
        );
      },
      itemCount: _persons.length,
    );
  }
}
