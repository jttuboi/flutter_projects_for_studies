import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_with_bloc/events/food_event.dart';
import 'package:food_with_bloc/models/food.dart';

class FoodBloc extends Bloc<FoodEvent, List<Food>> {
  FoodBloc() : super([]) {
    on<AddFood>((event, emit) {
      final newState = List<Food>.from(state);
      if (event.newFood.name.isNotEmpty) {
        newState.add(event.newFood);
        emit(newState);
      }
    });
    on<DeleteFood>((event, emit) {
      final newState = List<Food>.from(state);
      newState.removeAt(event.deletedIndex);
      emit(newState);
    });
  }
}
