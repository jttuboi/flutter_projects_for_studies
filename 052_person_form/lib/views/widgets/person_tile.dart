import 'package:flutter/material.dart';
import 'package:person_form/models/models/person.dart';
import 'package:person_form/views/pages/person_form_page.dart';

class PersonTile extends StatelessWidget {
  const PersonTile({required Person person, required VoidCallback onEditFinished, Key? key})
      : _person = person,
        _onEditFinished = onEditFinished,
        super(key: key);

  final Person _person;
  final VoidCallback _onEditFinished;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: (_person.picture == null) ? Image.asset('assets/default_avatar.png') : Image.file(_person.picture!),
        ),
      ),
      title: Text(_person.name),
      onTap: () async {
        await Navigator.pushNamed(context, PersonFormPage.routeName, arguments: _person);
        _onEditFinished();
      },
    );
  }
}
