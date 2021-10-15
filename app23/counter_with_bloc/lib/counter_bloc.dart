import 'package:bloc/bloc.dart';

abstract class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }
  @override
  void onChange(Change<int> change) {
    print('onChange: CounterBloc inside, $change');
    super.onChange(change);
  }

  @override
  void onEvent(CounterEvent event) {
    print('onEvent: CounterBloc inside, $event');
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    print('onTransition: CounterBloc inside, $transition');
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('onError: CounterBloc inside, $error, $stackTrace');
    super.onError(error, stackTrace);
  }
}
