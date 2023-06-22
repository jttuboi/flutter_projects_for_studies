import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_city_by_cep/search_cep_state.dart';

class SearchCepBloc extends Bloc<String, SearchCepState> {
  SearchCepBloc(this.dio) : super(const SearchCepSuccess({})) {
    on<String>((event, emit) async {
      emit(SearchCepLoading());

      try {
        final response = await dio.get('https://viacep.com.br/ws/$event/json/');
        emit(SearchCepSuccess(response.data as Map));
      } catch (e) {
        emit(const SearchCepError('Erro na pesquisa'));
      }
    });
  }

  final Dio dio;
}
