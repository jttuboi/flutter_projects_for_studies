import 'package:equatable/equatable.dart';

class Meta with EquatableMixin {
  const Meta({this.previousPage = -1, this.currentPage = -1, this.nextPage = -1, this.totalPages = 0, this.totalEntries = 0});

  const Meta.empty()
      : previousPage = -1,
        currentPage = -1,
        nextPage = -1,
        totalPages = 0,
        totalEntries = 0;

  final int previousPage;
  final int currentPage;
  final int nextPage;
  final int totalPages;
  final int totalEntries;

  @override
  List<Object?> get props => [previousPage, currentPage, nextPage, totalPages, totalEntries];

  @override
  bool? get stringify => true;

  bool get isFirstPage => previousPage == -1;

  bool get isLastPage => nextPage == -1;
}

extension MetaExtension on Meta {
  static Meta fromMap(Map<String, dynamic> map) {
    return Meta(
      previousPage: map['previous_page'] ?? -1,
      currentPage: map['current_page'] ?? -1,
      nextPage: map['next_page'] ?? -1,
      totalPages: map['total_pages'] ?? 0,
      totalEntries: map['total_entries'] ?? 0,
    );
  }
}
