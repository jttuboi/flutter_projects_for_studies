import 'package:flutter_test/flutter_test.dart';
import 'package:products/domain/enums/product_type.dart';
import 'package:products/domain/models/product_model.dart';
import 'package:products/domain/utils.dart';

void main() {
  group('ProductModel', () {
    test('creates properly', () {
      final productModel = ProductModel(
        id: 'id',
        title: 'title',
        type: ProductType.vegan,
        description: 'description',
        filename: 'filename',
        price: 2.22,
        rating: 2,
        created: DateTime(2002, 2, 22),
      );

      expect(productModel.id, 'id');
      expect(productModel.title, 'title');
      expect(productModel.type, ProductType.vegan);
      expect(productModel.description, 'description');
      expect(productModel.filename, 'filename');
      expect(productModel.price, 2.22);
      expect(productModel.rating, 2);
      expect(productModel.created, DateTime(2002, 2, 22));
      expect(productModel.picturePath, isEmpty);
    });

    test('instanciates a new ProductModel from map', () {
      final productModel = ProductModel.fromMap('id', {
        ProductModelMap.title: 'title',
        ProductModelMap.type: 'vegan',
        ProductModelMap.description: 'description',
        ProductModelMap.filename: 'filename',
        ProductModelMap.price: 2.22,
        ProductModelMap.rating: 2,
        ProductModelMap.created: DateTime(2002, 2, 22).millisecondsSinceEpoch,
      });

      expect(productModel.id, 'id');
      expect(productModel.title, 'title');
      expect(productModel.type, ProductType.vegan);
      expect(productModel.description, 'description');
      expect(productModel.filename, 'filename');
      expect(productModel.price, 2.22);
      expect(productModel.rating, 2);
      expect(productModel.created, DateTime(2002, 2, 22));
      expect(productModel.picturePath, isEmpty);
    });

    test('creates a map from ProductModel. created field must update with a new datetime', () {
      final productModel = ProductModel(
        id: 'id',
        title: 'title',
        type: ProductType.vegan,
        description: 'description',
        filename: 'filename',
        price: 2.22,
        rating: 2,
        created: DateTime(1999, 9, 19),
      );

      expect(productModel.toMap(DateTime(2002, 2, 22)), {
        ProductModelMap.title: 'title',
        ProductModelMap.type: 'vegan',
        ProductModelMap.description: 'description',
        ProductModelMap.filename: 'filename',
        ProductModelMap.price: 2.22,
        ProductModelMap.rating: 2,
        ProductModelMap.created: DateTime(2002, 2, 22).millisecondsSinceEpoch,
      });
    });

    test('copies ProductModel', () {
      final productModelCopied = ProductModel(
        id: 'id',
        title: 'title',
        type: ProductType.vegan,
        description: 'description',
        filename: 'filename',
        price: 2.22,
        rating: 2,
        created: DateTime(2002, 2, 22),
        picturePath: 'picturePath',
      ).copyWith(
        id: 'new id',
        type: ProductType.meat,
        filename: 'new filename',
        rating: 5,
        picturePath: 'new picturePath',
      );

      expect(productModelCopied.id, 'new id');
      expect(productModelCopied.title, 'title');
      expect(productModelCopied.type, ProductType.meat);
      expect(productModelCopied.description, 'description');
      expect(productModelCopied.filename, 'new filename');
      expect(productModelCopied.price, 2.22);
      expect(productModelCopied.rating, 5);
      expect(productModelCopied.created, DateTime(2002, 2, 22));
      expect(productModelCopied.picturePath, 'new picturePath');

      final productModelCopied2 = ProductModel(
        id: 'id',
        title: 'title',
        type: ProductType.vegan,
        description: 'description',
        filename: 'filename',
        price: 2.22,
        rating: 2,
        created: DateTime(1999, 9, 19),
        picturePath: 'picturePath',
      ).copyWith(
        title: 'new title',
        description: 'new description',
        price: 5.55,
        created: DateTime(2005, 5, 15),
      );

      expect(productModelCopied2.id, 'id');
      expect(productModelCopied2.title, 'new title');
      expect(productModelCopied2.type, ProductType.vegan);
      expect(productModelCopied2.description, 'new description');
      expect(productModelCopied2.filename, 'filename');
      expect(productModelCopied2.price, 5.55);
      expect(productModelCopied2.rating, 2);
      expect(productModelCopied2.created, DateTime(2005, 5, 15));
      expect(productModelCopied2.picturePath, 'picturePath');
    });
  });
}
