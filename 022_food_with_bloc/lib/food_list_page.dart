import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_with_bloc/blocs/food_bloc.dart';
import 'package:food_with_bloc/events/food_event.dart';
import 'package:food_with_bloc/models/food.dart';

class FoodListPage extends StatelessWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food with Bloc')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<FoodBloc, List<Food>>(
          builder: (context, foodList) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(foodList[index].name),
                    onTap: () => BlocProvider.of<FoodBloc>(context).add(DeleteFood(index)),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
