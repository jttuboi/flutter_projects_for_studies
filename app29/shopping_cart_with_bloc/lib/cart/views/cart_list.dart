import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_with_bloc/cart/cart.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const CircularProgressIndicator();
        }
        if (state is CartLoaded) {
          return ListView.separated(
            itemCount: state.cart.items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              final item = state.cart.items[index];
              return Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.hardEdge,
                child: ListTile(
                  leading: const Icon(Icons.done),
                  title: Text(item.name, style: Theme.of(context).textTheme.headline6),
                  onLongPress: () {
                    context.read<CartBloc>().add(CartItemRemoved(item));
                  },
                ),
              );
            },
          );
        }
        return const Text('Something went wrong!');
      },
    );
  }
}
