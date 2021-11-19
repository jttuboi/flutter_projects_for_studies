import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_with_bloc/cart/cart.dart';
import 'package:shopping_cart_with_bloc/catalog/catalog.dart';
import 'package:shopping_repository/shopping_repository.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final ShoppingRepository _shoppingRepository = ShoppingRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CatalogBloc(shoppingRepository: _shoppingRepository)..add(CatalogStarted())),
        BlocProvider(create: (_) => CartBloc(shoppingRepository: _shoppingRepository)..add(CartStarted())),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (_) => CatalogPage(),
          '/cart': (_) => CartPage(),
        },
      ),
    );
  }
}
