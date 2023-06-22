part of 'tab_bloc.dart';

enum AppTab {
  todos,
  stats,
}

extension AppTabExtension on AppTab {
  bool get isTodosTab => this == AppTab.todos;
  bool get isStatsTab => this == AppTab.stats;
}
