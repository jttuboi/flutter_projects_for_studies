import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart_with_bloc/cart/cart.dart';
import 'package:shopping_cart_with_bloc/catalog/catalog.dart';

class CatalogItem extends StatelessWidget {
  const CatalogItem(this.item, {Key? key}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(aspectRatio: 1, child: ColoredBox(color: item.color)),
            const SizedBox(width: 24),
            Expanded(child: Text(item.name, style: Theme.of(context).textTheme.headline6)),
            const SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.item, Key? key}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const CircularProgressIndicator();
        }
        if (state is CartLoaded) {
          final isInCart = state.cart.items.contains(item);
          return TextButton(
            style: TextButton.styleFrom(onSurface: Theme.of(context).primaryColor),
            onPressed: isInCart ? null : () => context.read<CartBloc>().add(CartItemAdded(item)),
            child: isInCart ? const Icon(Icons.check, semanticLabel: 'ADDED') : const Text('ADD'),
          );
        }
        return const Text('Something went wrong!');
      },
    );
  }
}
