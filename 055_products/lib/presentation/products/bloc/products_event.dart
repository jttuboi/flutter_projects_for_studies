part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductsRequested extends ProductsEvent {
  const ProductsRequested();
}

class ProductDeleted extends ProductsEvent {
  const ProductDeleted({required this.productId});

  final String productId;

  @override
  List<Object> get props => [productId];
}
