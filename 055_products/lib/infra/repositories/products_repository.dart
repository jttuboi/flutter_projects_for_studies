import 'package:get_it/get_it.dart';
import 'package:products/domain/models/product_model.dart';
import 'package:products/domain/repositories/products_repository.dart';
import 'package:products/domain/services/database_service.dart';
import 'package:products/domain/services/device_service.dart';

class ProductsRepository implements IProductsRepository {
  ProductsRepository({IDatabaseService? databaseService, IDeviceService? deviceService}) {
    this.databaseService = databaseService ?? GetIt.I.get<IDatabaseService>();
    this.deviceService = deviceService ?? GetIt.I.get<IDeviceService>();
  }

  late final IDatabaseService databaseService;
  late final IDeviceService deviceService;
  final List<ProductModel> cacheProducts = [];

  @override
  Future<void> deleteProduct(String id) async {
    final index = cacheProducts.indexWhere((productModel) => id == productModel.id);
    await databaseService.deletePicture(cacheProducts[index].filename);
    cacheProducts.removeAt(index);
    await databaseService.delete(id);
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    if (cacheProducts.isEmpty) {
      final products = await databaseService.getAll();

      for (final product in products) {
        final devicePicturePath = await databaseService.downloadPicture(filename: product.filename);
        cacheProducts.add(product.copyWith(picturePath: devicePicturePath));
      }
    }

    return List.of(cacheProducts..sort((productModel1, productModel2) => productModel1.title.compareTo(productModel2.title)));
  }

  @override
  Future<void> updateProduct(ProductModel productModel) async {
    final index = cacheProducts.indexWhere((cacheProductModel) => productModel.id == cacheProductModel.id);

    final oldFilename = cacheProducts[index].filename;
    if (oldFilename != productModel.filename) {
      await databaseService.updatePicture(productModel.filename, oldFilename);
    }

    cacheProducts
      ..removeAt(index)
      ..add(productModel);
    await databaseService.update(productModel);
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    return cacheProducts.firstWhere((productModel) => id == productModel.id);
  }
}
