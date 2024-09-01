import 'package:products/domain/models/product_model.dart';

abstract class IProductsRepository {
  Future<List<ProductModel>> getProducts();

  Future<void> updateProduct(ProductModel productModel);

  Future<void> deleteProduct(String id);

  Future<ProductModel> getProduct(String id);
}
