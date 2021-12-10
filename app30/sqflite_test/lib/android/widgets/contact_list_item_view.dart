import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_test/android/views/details_view.dart';
import 'package:sqflite_test/models/contact_model.dart';

class ContactListItem extends StatelessWidget {
  const ContactListItem({required this.model, Key? key}) : super(key: key);

  final ContactModel model;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(File(model.image)),
          ),
        ),
      ),
      title: Text(model.name),
      subtitle: Text(model.phone),
      trailing: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsView(id: model.id)),
          );
        },
        child: Icon(Icons.person, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
