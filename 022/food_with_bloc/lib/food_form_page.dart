import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_with_bloc/blocs/food_bloc.dart';
import 'package:food_with_bloc/events/food_event.dart';
import 'package:food_with_bloc/food_list_page.dart';
import 'package:food_with_bloc/models/food.dart';

class FoodFormPage extends StatefulWidget {
  const FoodFormPage({Key? key}) : super(key: key);

  @override
  State<FoodFormPage> createState() => _FoodFormPageState();
}

class _FoodFormPageState extends State<FoodFormPage> {
  final _textEditingController = TextEditingController();
  late String _foodName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food with Bloc'),
      ),
      body: Container(
        padding: const EdgeInsets.all(36),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Bloc Tutorial', style: TextStyle(fontSize: 42)),
              const SizedBox(height: 20),
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(labelText: 'Food'),
                style: const TextStyle(fontSize: 22),
                onChanged: (text) => setState(() => _foodName = text),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'button1',
            onPressed: () {
              _addFood(context);
            },
            child: const Icon(Icons.save),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'button2',
            onPressed: () => _goToFoodList(context),
            child: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }

  void _addFood(BuildContext context) {
    BlocProvider.of<FoodBloc>(context).add(AddFood(Food(_foodName)));
    _textEditingController.clear();
  }

  void _goToFoodList(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const FoodListPage()));
  }
}
