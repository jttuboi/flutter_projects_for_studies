import 'package:flutter/material.dart';
import 'package:person_form/controllers/persons_controller.dart';
import 'package:person_form/models/models/person.dart';
import 'package:person_form/models/repositories/persons_repository.dart';
import 'package:person_form/models/services/api_service.dart';
import 'package:person_form/views/pages/person_form_page.dart';
import 'package:person_form/views/widgets/person_search_delegate.dart';
import 'package:person_form/views/widgets/person_tile.dart';

class PersonsPage extends StatefulWidget {
  const PersonsPage._(PersonsController controller, {Key? key})
      : _controller = controller,
        super(key: key);

  static const routeName = '/';
  static Route route({required ApiService apiService}) {
    return MaterialPageRoute(builder: (context) => PersonsPage._(PersonsController(PersonsRepository(apiService))));
  }

  final PersonsController _controller;

  @override
  State<PersonsPage> createState() => _PersonsPageState();
}

class _PersonsPageState extends State<PersonsPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final queryName =
                  await showSearch(context: context, delegate: PersonSearchDelegate(persons: await widget._controller.getSuggestions()));
              setState(() => _query = queryName);
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, PersonFormPage.routeName).then((_) {
              setState(() {});
            }),
          ),
        ],
      ),
      body: FutureBuilder(
        future: widget._controller.getPersonsByQuery(query: _query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final persons = snapshot.data as List<Person>;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: RefreshIndicator(
              onRefresh: () async => setState(() => _query = ''),
              child: ListView.separated(
                itemBuilder: (context, index) => PersonTile(person: persons[index], onEditFinished: () => setState(() {})),
                separatorBuilder: (context, index) => const Divider(indent: 72),
                itemCount: persons.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
