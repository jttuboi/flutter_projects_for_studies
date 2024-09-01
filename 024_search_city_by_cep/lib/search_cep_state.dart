import 'package:equatable/equatable.dart';

abstract class SearchCepState {}

class SearchCepSuccess extends Equatable implements SearchCepState {
  const SearchCepSuccess(this.data);
  final Map data;

  @override
  List<Object?> get props => [data];
}

class SearchCepLoading implements SearchCepState {
  SearchCepLoading();
}

class SearchCepError extends Equatable implements SearchCepState {
  const SearchCepError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
