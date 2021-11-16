part of 'tab_bloc.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
}

class TabUpdated extends TabEvent {
  const TabUpdated(this.tab);

  final AppTab tab;

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabUpdated($tab)';
}
