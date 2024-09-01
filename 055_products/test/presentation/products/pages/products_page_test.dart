import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:products/presentation/products/bloc/products_bloc.dart';
import 'package:products/presentation/products/pages/products_page.dart';
import 'package:products/presentation/products/view_models/product_view_model.dart';
import 'package:products/presentation/products/widgets/product_item.dart';

import '../../../mocks.dart';

void main() {
  group('ProductsPage', () {
    final mockProductsBloc = MockProductsBloc();

    testWidgets('renders properly', (tester) async {
      when(() => mockProductsBloc.state).thenReturn(const ProductsInProgress());
      await tester.pumpProductsPage(mockProductsBloc);

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
    });

    testWidgets('renders properly when state is ProductsInProgress', (tester) async {
      when(() => mockProductsBloc.state).thenReturn(const ProductsInProgress());
      await tester.pumpProductsPage(mockProductsBloc);

      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders properly when state is ProductsReady', (tester) async {
      when(() => mockProductsBloc.state).thenReturn(const ProductsReady(productsViewModel));
      await tester.pumpProductsPage(mockProductsBloc);

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ProductItem), findsNWidgets(2));
    });

    testWidgets('shows dialog delete when clicked in button delete', (tester) async {
      when(() => mockProductsBloc.state).thenReturn(const ProductsReady(productViewModelWithOne));
      await tester.pumpProductsPage(mockProductsBloc);

      await tester.tap(find.byIcon(Icons.more_horiz_rounded));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delete'));
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Do you want to delete the product title?'), findsOneWidget);
      expect(find.text('This action can not be undone.'), findsOneWidget);
      expect(find.byType(TextButton), findsNWidgets(2));
      expect(find.text('No'), findsOneWidget);
      expect(find.text('Yes'), findsOneWidget);
    });

    testWidgets('backs to products screen when is in delete dialog and clicked in button no', (tester) async {
      when(() => mockProductsBloc.state).thenReturn(const ProductsReady(productViewModelWithOne));
      await tester.pumpProductsPage(mockProductsBloc);

      await tester.tap(find.byIcon(Icons.more_horiz_rounded));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delete'));
      await tester.pump();

      await tester.tap(find.text('No'));
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('backs to products screen when is in delete dialog and clicked in button yes', (tester) async {
      when(() => mockProductsBloc.state).thenReturn(const ProductsReady(productViewModelWithOne));
      when(() => mockProductsBloc.add(const ProductDeleted(productId: 'id'))).thenReturn(null);
      await tester.pumpProductsPage(mockProductsBloc);

      await tester.tap(find.byIcon(Icons.more_horiz_rounded));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delete'));
      await tester.pump();

      await tester.tap(find.text('Yes'));
      await tester.pumpAndSettle();

      verify(() => mockProductsBloc.add(const ProductDeleted(productId: 'id'))).called(1);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('shows message successfully deleted product after bloc deleted', (tester) async {
      when(() => mockProductsBloc.state).thenReturn(const AfterDeleteProductsReady(productViewModelWithOne));
      whenListen(mockProductsBloc, Stream<ProductsState>.fromIterable([const AfterDeleteProductsReady(productViewModelWithOne)]));
      await tester.pumpProductsPage(mockProductsBloc);

      await tester.pump();

      expect(find.text('Successfully deleted product.'), findsOneWidget);
    });
  });
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpProductsPage(ProductsBloc productsBloc) async {
    await pumpWidget(MaterialApp(
      home: BlocProvider<ProductsBloc>(
        create: (context) => productsBloc,
        child: const ProductsPage(),
      ),
    ));
  }
}

const productsViewModel = <ProductViewModel>[
  ProductViewModel(
    id: 'id',
    filename: 'empty_picture.png',
    title: 'title',
    type: 'bakery',
    created: '02/02/2002',
    rating: 4,
    emptiesRating: 1,
    price: r'R$1,11',
    picturePath: 'picturePath',
  ),
  ProductViewModel(
    id: 'id2',
    filename: 'empty_picture.png',
    title: 'title2',
    type: 'bakery',
    created: '02/02/2002',
    rating: 4,
    emptiesRating: 1,
    price: r'R$1,11',
    picturePath: 'picturePath2',
  ),
];

const productViewModelWithOne = <ProductViewModel>[
  ProductViewModel(
    id: 'id',
    filename: 'empty_picture.png',
    title: 'title',
    type: 'bakery',
    created: '02/02/2002',
    rating: 4,
    emptiesRating: 1,
    price: r'R$1,11',
    picturePath: 'picturePath3',
  ),
];
