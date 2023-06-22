import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/todos/blocs/tab_bloc.dart';
import 'package:todos/todos/core/core.dart';
import 'package:todos/todos/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Flutter todos'),
            actions: [
              FilterButton(visible: state.isTodosTab),
              const ExtraActions(),
            ],
          ),
          body: state.isTodosTab ? const FilteredTodosTab() : const StatsTab(),
          floatingActionButton: FloatingActionButton(
            key: Keys.addTodoFab,
            onPressed: () => Navigator.pushNamed(context, Routes.addTodo),
            tooltip: 'Flutter todos',
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: TabSelector(
            activeTab: state,
            onTabSelected: (tab) => context.read<TabBloc>().add(TabUpdated(tab)),
          ),
        );
      },
    );
  }
}
