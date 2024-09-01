import 'package:flutter/material.dart';
import 'package:todos/todos/core/core.dart';
import 'package:todos/todos/models/models.dart';

typedef OnSaveCallback = Function(String task, String note);

class AddEditPage extends StatefulWidget {
  const AddEditPage({
    required this.isEditing,
    required this.onSave,
    this.todo = Todo.empty,
    Key? key,
  }) : super(key: key ?? Keys.addTodoPage);

  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo todo;

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _taskController = TextEditingController();
  final _noteController = TextEditingController();

  bool get isEditing => widget.isEditing;

  @override
  void initState() {
    super.initState();
    _taskController.text = isEditing ? widget.todo.task : '';
    _noteController.text = isEditing ? widget.todo.note : '';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Todo' : 'Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _taskController,
                key: Keys.taskField,
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: const InputDecoration(hintText: 'What needs to be done?'),
                validator: (task) => task!.trim().isEmpty ? 'Please enter some text' : null,
              ),
              TextFormField(
                controller: _noteController,
                key: Keys.noteField,
                maxLines: 10,
                style: textTheme.subtitle1,
                decoration: const InputDecoration(hintText: 'Additional Notes...'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: isEditing
          ? FloatingActionButton(
              key: Keys.saveTodoFab,
              tooltip: 'Save changes',
              child: const Icon(Icons.check),
              onPressed: () => _onSaved(context),
            )
          : FloatingActionButton(
              key: Keys.saveNewTodo,
              tooltip: 'Add Todo',
              child: const Icon(Icons.add),
              onPressed: () => _onSaved(context),
            ),
    );
  }

  void _onSaved(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSave(_taskController.text, _noteController.text);
      Navigator.pop(context);
    }
  }
}
