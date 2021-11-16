enum ExtraAction {
  toggleAllComplete,
  clearCompleted,
}

extension ExtraActionExtension on ExtraAction {
  bool get isToggleAllComplete => this == ExtraAction.toggleAllComplete;
  bool get isClearCompleted => this == ExtraAction.clearCompleted;
}
