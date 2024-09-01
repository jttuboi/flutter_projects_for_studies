import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:products/domain/repositories/products_repository.dart';
import 'package:products/presentation/products/view_models/product_view_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({IProductsRepository? productsRepository}) : super(const ProductsInProgress()) {
    this.productsRepository = productsRepository ?? GetIt.I.get<IProductsRepository>();
    on<ProductsRequested>(_onProductsRequested);
    on<ProductDeleted>(_onProductsDeleted);

    add(const ProductsRequested());
  }

  late final IProductsRepository productsRepository;

  Future<void> _onProductsRequested(ProductsRequested event, Emitter<ProductsState> emit) async {
    emit(ProductsReady(await _getProducts()));
  }

  Future<void> _onProductsDeleted(ProductDeleted event, Emitter<ProductsState> emit) async {
    await productsRepository.deleteProduct(event.productId);
    emit(AfterDeleteProductsReady(await _getProducts()));
  }

  Future<List<ProductViewModel>> _getProducts() async {
    final products = await productsRepository.getProducts();
    return products.map<ProductViewModel>((product) => ProductViewModel.fromProductModel(product)).toList();
  }
}
