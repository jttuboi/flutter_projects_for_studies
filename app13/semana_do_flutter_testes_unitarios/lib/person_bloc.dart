import 'package:bloc/bloc.dart';
import 'package:semana_do_flutter_testes_unitarios/person_repository.dart';
import 'package:semana_do_flutter_testes_unitarios/person_state.dart';

enum PersonEvent {
  clear,
  fetch, // busca
}

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc(this.repository) : super(PersonListState([]));

  final PersonRepository repository;

  @override
  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    if (event == PersonEvent.clear) {
      yield PersonListState([]);
    } else if (event == PersonEvent.fetch) {
      yield PersonLoadingState();
      try {
        final list = await repository.getPerson();
        yield PersonListState(list);
      } catch (e) {
        yield PersonErrorState();
      }
    }
  }
}
