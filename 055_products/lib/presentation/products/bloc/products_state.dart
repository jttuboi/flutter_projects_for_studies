part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInProgress extends ProductsState {
  const ProductsInProgress();
}

class ProductsReady extends ProductsState {
  const ProductsReady(this.products);

  final List<ProductViewModel> products;

  @override
  List<Object> get props => [products];
}

class AfterDeleteProductsReady extends ProductsReady {
  const AfterDeleteProductsReady(List<ProductViewModel> products) : super(products);
}
