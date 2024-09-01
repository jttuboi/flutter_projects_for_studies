extension ListExtension<T> on List<T> {
  List<T> clone() => List.from(this);
  Future<List<T>> cloneAsync({List<T> addAll = const []}) {
    if (addAll.isEmpty) {
      return Future.value(List.from(this));
    }
    final newList = List.from(this);
    for (final newItem in addAll) {
      newList.add(newItem);
    }
    return Future.value(List.from(newList));
  }
}
