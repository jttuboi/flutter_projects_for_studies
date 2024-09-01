import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/todos/todos.dart';

class StatsTab extends StatelessWidget {
  const StatsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Completed todos', style: TextStyle(fontSize: 20)),
              Text(state.completedTodosQuantity, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 8),
              const Text('Active todos', style: TextStyle(fontSize: 20)),
              Text(state.activeTodosQuantity, style: const TextStyle(fontSize: 20)),
            ],
          ),
        );
      },
    );
  }
}
