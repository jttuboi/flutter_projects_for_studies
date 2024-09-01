part of 'tabs_bloc.dart';

abstract class TabsEvent extends Equatable {
  const TabsEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends TabsEvent {
  const TabChanged({required this.tabIndex});

  final int tabIndex;

  @override
  List<Object> get props => [tabIndex];
}

class MarkAllCompleted extends TabsEvent {}

class MarkAllIncompleted extends TabsEvent {}

class ClearCompleted extends TabsEvent {}
