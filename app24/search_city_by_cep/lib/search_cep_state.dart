abstract class SearchCepState {}

class SearchCepSuccess implements SearchCepState {
  SearchCepSuccess(this.data);
  final Map data;
}

class SearchCepLoading implements SearchCepState {
  SearchCepLoading();
}

class SearchCepError implements SearchCepState {
  SearchCepError(this.message);
  final String message;
}
