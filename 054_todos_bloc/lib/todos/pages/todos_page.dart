import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_bloc/todos/todos.dart';

class TodosPage extends StatelessWidget {
  const TodosPage._({required ITodosRepository todosRepository, Key? key})
      : _todosRepository = todosRepository,
        super(key: key);

  static const routeName = '/';
  static Route route({required TodosRepository todosRepository}) {
    return MaterialPageRoute(builder: (context) => TodosPage._(todosRepository: todosRepository));
  }

  final ITodosRepository _todosRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StatsBloc(todosRepository: _todosRepository)),
        BlocProvider(create: (context) => TodosBloc(todosRepository: _todosRepository)..add(TodosTabOpened())),
        BlocProvider(
          create: (context) => TabsBloc(
            todosRepository: _todosRepository,
            statsBloc: BlocProvider.of<StatsBloc>(context),
            todosBloc: BlocProvider.of<TodosBloc>(context),
          ),
        ),
      ],
      child: const _TodosView(),
    );
  }
}

class _TodosView extends StatelessWidget {
  const _TodosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          if (context.watch<TabsBloc>().state.isTodosTab)
            PopupMenuButton(
              icon: const Icon(Icons.filter_list),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () => context.read<TodosBloc>().add(ShowAllTodos()),
                    child: const Text('Show all'),
                  ),
                  PopupMenuItem(
                    onTap: () => context.read<TodosBloc>().add(ShowActiveTodos()),
                    child: const Text('Show active'),
                  ),
                  PopupMenuItem(
                    onTap: () => context.read<TodosBloc>().add(ShowCompletedTodos()),
                    child: const Text('Show completed'),
                  ),
                ];
              },
            ),
          PopupMenuButton(
            icon: const Icon(Icons.more_horiz),
            itemBuilder: (context) {
              final hasIncomplete = context.read<TabsBloc>().state.hasIncomplete;
              return [
                PopupMenuItem(
                  onTap: () => context.read<TabsBloc>().add(hasIncomplete ? MarkAllCompleted() : MarkAllIncompleted()),
                  child: hasIncomplete ? const Text('Mark all completed') : const Text('Mark all incompleted'),
                ),
                PopupMenuItem(
                  onTap: () => context.read<TabsBloc>().add(ClearCompleted()),
                  child: const Text('Clear completed'),
                ),
              ];
            },
          ),
        ],
      ),
      body: const TabsBody(),
      bottomNavigationBar: const TabsBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, TodoFormPage.routeName, arguments: {
            'onSaved': (todo) {
              Navigator.pop(context);
              context.read<TodosBloc>().add(TodoAdded(todo: todo));
            },
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TabsBody extends StatelessWidget {
  const TabsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsBloc, TabsState>(
      builder: (context, state) => state.isTodosTab ? const TodosTab() : const StatsTab(),
    );
  }
}

class TabsBar extends StatelessWidget {
  const TabsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsBloc, TabsState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.currentTabIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todos'),
            BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Stats'),
          ],
          onTap: (tabIndex) {
            _forceHideSnackBarWhenChangeToStats(tabIndex, context);
            context.read<TabsBloc>().add(TabChanged(tabIndex: tabIndex));
          },
        );
      },
    );
  }

  void _forceHideSnackBarWhenChangeToStats(int tabIndex, BuildContext context) {
    if (tabIndex == 1) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    }
  }
}
