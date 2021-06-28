import 'package:flutter/material.dart';
import 'package:user_list/components/user_tile.dart';
import 'package:user_list/data/dummy_users.dart';

class UserList extends StatelessWidget {
  final String title;

  UserList({required this.title});

  @override
  Widget build(BuildContext context) {
    final users = {...DUMMY_USERS};

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      // este componente serve para criar listas on demand, sem a necessidade
      // de carregar todos os itens de uma vez
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, i) => UserTile(users.values.elementAt(i)),
      ),
    );
  }
}
