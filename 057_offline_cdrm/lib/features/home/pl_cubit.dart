import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../exceptions/offline_exception.dart';
import '../../repositories/pokemon_repository.dart';

part 'pl_state.dart';

class PlCubit extends Cubit<PlState> {
  PlCubit({PokemonRepository? pokemonRepository})
      : _pokemonRepository = pokemonRepository ?? PokemonRepository(),
        super(PlInitial());

  final PokemonRepository _pokemonRepository;

  Future<void> init() async {
    try {
      final list = await _pokemonRepository.getAll();
      //emit(list);
    } catch (e) {
      if (e is OfflineException) {
        // emit();
      }
    }
  }
}
