import 'package:flutter/material.dart';
import 'package:todos/todos/blocs/blocs.dart';
import 'package:todos/todos/core/core.dart';

class TabSelector extends StatelessWidget {
  const TabSelector({
    required this.activeTab,
    required this.onTabSelected,
    Key? key,
  }) : super(key: key);

  final AppTab activeTab;
  final Function(AppTab tab) onTabSelected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: Keys.tabs,
      currentIndex: activeTab.index,
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list, key: Keys.todoTab),
          label: 'Todos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart, key: Keys.statsTab),
          label: 'Stats',
        ),
      ],
    );
  }
}
