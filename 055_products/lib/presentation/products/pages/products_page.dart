import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/presentation/product_form/pages/product_form_page.dart';
import 'package:products/presentation/products/bloc/products_bloc.dart';
import 'package:products/presentation/products/view_models/product_view_model.dart';
import 'package:products/presentation/products/widgets/product_item.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  static const routeName = '/';

  static Route route() => MaterialPageRoute(builder: (context) {
        return BlocProvider(
          create: (context) => ProductsBloc(),
          child: const ProductsPage(),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocConsumer<ProductsBloc, ProductsState>(
          listener: (context, state) {
            if (state is AfterDeleteProductsReady) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Successfully deleted product.'),
                duration: Duration(seconds: 1),
              ));
            }
          },
          builder: (context, state) {
            if (state is ProductsInProgress) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: [
                const SizedBox(height: 8),
                ...(state as ProductsReady).products.map<ProductItem>((productViewModel) => ProductItem(
                      productViewModel,
                      onEditPressed: () async {
                        await Navigator.pushNamed(context, ProductFormPage.routeName, arguments: productViewModel.id).whenComplete(() {
                          context.read<ProductsBloc>().add(const ProductsRequested());
                        });
                      },
                      onDeletePressed: () => _showDialogDelete(context, productViewModel),
                    )),
                const SizedBox(height: 8),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showDialogDelete(BuildContext context, ProductViewModel productViewModel) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Do you want to delete the product ${productViewModel.title}?'),
        content: const Text('This action can not be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
          TextButton(
            onPressed: () {
              context.read<ProductsBloc>().add(ProductDeleted(productId: productViewModel.id));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
