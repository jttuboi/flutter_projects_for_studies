enum VisibilityFilter {
  all,
  active,
  completed,
}

extension VisibilityFilterExtension on VisibilityFilter {
  bool get isAll => this == VisibilityFilter.all;
  bool get isActive => this == VisibilityFilter.active;
  bool get isCompleted => this == VisibilityFilter.completed;
}
