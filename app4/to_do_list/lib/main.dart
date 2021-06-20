import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/task.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
      ),
      body: TaskList(),
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = <Task>[];
  TextEditingController textEditingController = TextEditingController();

  void _addTask(String text) {
    setState(() {
      tasks.add(Task(text));
    });
    textEditingController.clear();
  }

  Widget _createTaskItem(Task task) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            task.finished ? Icons.check_box : Icons.check_box_outline_blank,
            size: 42.0,
            color: Colors.green,
          ),
          padding: EdgeInsets.only(left: 10.0, right: 30.0),
          onPressed: () => _finishTask(task),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.text,
              style: TextStyle(
                decoration: task.finished
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(task.date.toIso8601String()),
          ],
        ),
      ],
    );
  }

  void _finishTask(Task task) {
    setState(() {
      task.finished = !task.finished;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: textEditingController,
            onSubmitted: _addTask,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) => _createTaskItem(tasks[index]),
          ),
        ),
      ],
    );
  }
}
