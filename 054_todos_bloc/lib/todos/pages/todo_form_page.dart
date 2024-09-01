import 'package:flutter/material.dart';
import 'package:todos_bloc/todos/todos.dart';

class TodoFormPage extends StatefulWidget {
  const TodoFormPage._({required Todo todo, required Function(Todo todo) onSaved, Key? key})
      : _todo = todo,
        _onSaved = onSaved,
        super(key: key);

  static const routeName = '/todo_form';
  static Route route({required Todo todo, required Function(Todo todo) onSaved}) {
    return MaterialPageRoute(builder: (context) => TodoFormPage._(todo: todo, onSaved: onSaved));
  }

  final Todo _todo;
  final Function(Todo todo) _onSaved;

  @override
  State<TodoFormPage> createState() => _TodoFormPageState();
}

class _TodoFormPageState extends State<TodoFormPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _subtitleController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget._todo.title);
    _subtitleController = TextEditingController(text: widget._todo.subtitle);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget._todo == Todo.empty ? const Text('Add todo') : const Text('Edit todo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  validator: (value) => (value == null || value.isEmpty) ? 'Cannot be empty.' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Content'),
                  controller: _subtitleController,
                  keyboardType: TextInputType.text,
                  validator: (value) => (value == null || value.isEmpty) ? 'Cannot be empty.' : null,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            widget._onSaved(widget._todo.copyWith(title: _titleController.text, subtitle: _subtitleController.text));
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
