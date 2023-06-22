import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_with_bloc/blocs/food_bloc.dart';
import 'package:food_with_bloc/blocs/food_bloc_observer.dart';
import 'package:food_with_bloc/food_form_page.dart';

void main() {
  Bloc.observer = FoodBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodBloc>(
      create: (context) => FoodBloc(),
      child: MaterialApp(
        title: 'Food with Bloc',
        theme: ThemeData(primarySwatch: Colors.blue, secondaryHeaderColor: Colors.blueAccent),
        home: const FoodFormPage(),
      ),
    );
  }
}
