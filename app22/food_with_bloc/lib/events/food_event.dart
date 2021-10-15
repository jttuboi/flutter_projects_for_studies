import 'package:food_with_bloc/models/food.dart';

abstract class FoodEvent {}

class AddFood extends FoodEvent {
  AddFood(this.newFood);
  final Food newFood;
}

class DeleteFood extends FoodEvent {
  DeleteFood(this.deletedIndex);
  final int deletedIndex;
}
