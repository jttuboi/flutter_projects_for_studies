import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:products/domain/enums/product_type.dart';
import 'package:products/domain/models/product_model.dart';
import 'package:products/presentation/products/bloc/products_bloc.dart';
import 'package:products/presentation/products/view_models/product_view_model.dart';

import '../../../mocks.dart';

void main() {
  group('ProductsBloc', () {
    final mockProductsRepository = MockProductsRepository();

    blocTest<ProductsBloc, ProductsState>(
      'adds ProductsRequested when instanciate it',
      setUp: () => when(mockProductsRepository.getProducts).thenAnswer((_) => Future.value([])),
      build: () => ProductsBloc(productsRepository: mockProductsRepository),
      expect: () {
        verify(mockProductsRepository.getProducts).called(1);
        return const <ProductsState>[ProductsReady([])];
      },
    );

    const repositoryCallQuantityWhenInstanciateTheBloc = 1;

    blocTest<ProductsBloc, ProductsState>(
      'emits [ProductsReady] when ProductsRequested is called',
      setUp: () => when(mockProductsRepository.getProducts).thenAnswer((_) => Future.value([])),
      build: () => ProductsBloc(productsRepository: mockProductsRepository),
      act: (bloc) => bloc.add(const ProductsRequested()),
      expect: () {
        verify(mockProductsRepository.getProducts).called(1 + repositoryCallQuantityWhenInstanciateTheBloc);
        return const <ProductsState>[ProductsReady([])];
      },
    );

    blocTest<ProductsBloc, ProductsState>(
      'emits [ProductsReady(products)] when ProductsRequested is called and products is not empty',
      setUp: () => when(mockProductsRepository.getProducts).thenAnswer((_) => Future.value(productsModel)),
      build: () => ProductsBloc(productsRepository: mockProductsRepository),
      act: (bloc) => bloc.add(const ProductsRequested()),
      expect: () => const <ProductsState>[ProductsReady(productsViewModel)],
    );

    const skipProductsRequestedOnConstructor = 1;

    blocTest<ProductsBloc, ProductsState>(
      'emits [AfterDeleteProductsReady] with a list without product deleted when ProductDeleted is called',
      setUp: () {
        when(() => mockProductsRepository.deleteProduct('id')).thenAnswer((_) => Future.value());
        when(mockProductsRepository.getProducts).thenAnswer((_) => Future.value([]));
      },
      build: () => ProductsBloc(productsRepository: mockProductsRepository),
      act: (bloc) => bloc.add(const ProductDeleted(productId: 'id')),
      skip: skipProductsRequestedOnConstructor,
      expect: () {
        verify(() => mockProductsRepository.deleteProduct('id')).called(1);
        return const <ProductsState>[AfterDeleteProductsReady([])];
      },
    );
  });
}

final productsModel = <ProductModel>[
  ProductModel(
    id: 'id',
    title: 'title',
    type: ProductType.bakery,
    description: 'description',
    filename: 'empty_picture.png',
    price: 1.11,
    rating: 4,
    created: DateTime(2002, 02, 02),
  ),
];

const productsViewModel = <ProductViewModel>[
  ProductViewModel(
    id: 'id',
    filename: 'empty_picture.png',
    title: 'title',
    type: 'Bakery',
    created: '02/02/2002',
    rating: 4,
    emptiesRating: 1,
    price: r'R$1,11',
    picturePath: 'picturePath',
  ),
];
