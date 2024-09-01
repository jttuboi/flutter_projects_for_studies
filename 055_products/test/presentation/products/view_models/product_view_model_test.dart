import 'package:flutter_test/flutter_test.dart';
import 'package:products/domain/enums/product_type.dart';
import 'package:products/domain/models/product_model.dart';
import 'package:products/presentation/products/view_models/product_view_model.dart';

void main() {
  group('ProductViewModel', () {
    test('creates properly', () {
      const productViewModel = ProductViewModel(
        id: 'id',
        filename: 'filename',
        title: 'title',
        type: 'bakery',
        created: '31/12/2001',
        rating: 2,
        emptiesRating: 3,
        price: r'R$10,00',
        picturePath: 'picturePath',
      );

      expect(productViewModel.id, 'id');
      expect(productViewModel.filename, 'filename');
      expect(productViewModel.title, 'title');
      expect(productViewModel.type, 'bakery');
      expect(productViewModel.created, '31/12/2001');
      expect(productViewModel.rating, 2);
      expect(productViewModel.emptiesRating, 3);
      expect(productViewModel.price, r'R$10,00');
      expect(productViewModel.picturePath, 'picturePath');
    });

    test('creates new ProductViewModel from ProductModel', () {
      final productViewModel = ProductViewModel.fromProductModel(ProductModel(
        id: 'id',
        title: 'title',
        type: ProductType.bakery,
        description: 'description',
        filename: 'filename',
        price: 10,
        rating: 2,
        created: DateTime(2001, 12, 31),
        picturePath: 'picturePath2',
      ));

      expect(productViewModel.id, 'id');
      expect(productViewModel.filename, 'filename');
      expect(productViewModel.title, 'title');
      expect(productViewModel.type, 'Bakery');
      expect(productViewModel.created, '31/12/2001');
      expect(productViewModel.rating, 2);
      expect(productViewModel.emptiesRating, 3);
      expect(productViewModel.price, r'R$10,00');
      expect(productViewModel.picturePath, 'picturePath2');
    });
  });
}
