part of 'tabs_bloc.dart';

class TabsState extends Equatable {
  const TabsState({
    this.isTodosTab = true,
    this.currentTabIndex = 0,
    this.hasIncomplete = false,
  });

  final bool isTodosTab;
  final int currentTabIndex;
  final bool hasIncomplete;

  @override
  List<Object> get props => [isTodosTab, currentTabIndex, hasIncomplete];

  TabsState copyWith({
    bool? isTodosTab,
    int? currentTabIndex,
    bool? hasIncomplete,
  }) {
    return TabsState(
      isTodosTab: isTodosTab ?? this.isTodosTab,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      hasIncomplete: hasIncomplete ?? this.hasIncomplete,
    );
  }
}
