enum Status { changing, ready }

extension StatusExtension on Status {
  bool get isChanging => this == Status.changing;
}
