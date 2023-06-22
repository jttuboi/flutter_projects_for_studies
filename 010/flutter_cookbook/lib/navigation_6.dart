import 'package:flutter/material.dart';

class Navigation6 extends StatelessWidget {
  const Navigation6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TodosScreen(
      todos: List.generate(
        20,
        (i) => Todo('Todo $i', 'Descrição do que aparecerá no Todo $i'),
      ),
    );
  }
}

class TodosScreen extends StatelessWidget {
  final List<Todo> todos;

  TodosScreen({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(todos[index].title),
          onTap: () {
            Navigator.push(
              context,
              // chama o detail screen onde é o conteúdo detalhado do Todo
              // ao criar a página, ele já passa diretamente qual todo deve chamar
              MaterialPageRoute(
                builder: (context) => DetailScreen(todo: todos[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Todo todo;

  DetailScreen({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(todo.description),
      ),
    );
  }
}

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}
