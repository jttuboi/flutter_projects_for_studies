import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sqflite_test/controllers/home_controller.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({required this.controller, Key? key}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Observer(
        builder: (_) {
          return controller.showSearch
              ? TextField(
                  autofocus: true,
                  decoration: const InputDecoration(labelText: "Pesquisar..."),
                  onSubmitted: (val) => controller.search(val),
                )
              : const Text("Meus Contato");
        },
      ),
      centerTitle: true,
      leading: ElevatedButton(
        onPressed: () {
          if (controller.showSearch) controller.search("");
          controller.toggleSearch();
        },
        child: Observer(
          builder: (_) => Icon(
            controller.showSearch ? Icons.close : Icons.search,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
