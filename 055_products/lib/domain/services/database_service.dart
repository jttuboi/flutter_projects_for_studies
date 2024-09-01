import 'package:products/domain/models/product_model.dart';

abstract class IDatabaseService {
  Future<void> delete(String id);

  Future<void> deletePicture(String filename);

  Future<List<ProductModel>> getAll();

  Future<void> update(ProductModel productModel);

  Future<void> updatePicture(String filename, String oldFilename);

  Future<String> downloadPicture({required String filename});
}
