import 'package:api_playground_flutter/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();

  @override
  void initState() {
    super.initState();
    controller.fetchAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.todos[index].title),
              );
            },
            itemCount: controller.todos.length,
          );
        },
      ),
    );
  }
}
