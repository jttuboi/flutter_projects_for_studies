import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sqflite_test/android/views/editor_contact_view.dart';
import 'package:sqflite_test/android/widgets/contact_list_item_view.dart';
import 'package:sqflite_test/android/widgets/search_appbar.dart';
import 'package:sqflite_test/controllers/home_controller.dart';
import 'package:sqflite_test/models/contact_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.search("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SearchAppBar(controller: controller),
        preferredSize: const Size.fromHeight(kToolbarHeight),
      ),
      body: Observer(
        builder: (_) => ListView.builder(
          itemCount: controller.contacts.length,
          itemBuilder: (ctx, i) {
            return ContactListItem(model: controller.contacts[i]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return EditorContactView(model: ContactModel(id: 0));
            }),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
