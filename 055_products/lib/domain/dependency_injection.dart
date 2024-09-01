import 'package:get_it/get_it.dart';
import 'package:products/domain/repositories/products_repository.dart';
import 'package:products/domain/services/database_service.dart';
import 'package:products/domain/services/device_service.dart';
import 'package:products/infra/repositories/products_repository.dart';
import 'package:products/infra/services/android_device_service.dart';
import 'package:products/infra/services/firebase_database_service.dart';

void setUpDependencyInjections() {
  GetIt.I.registerSingletonAsync<IDeviceService>(() async => AndroidDeviceService());
  GetIt.I.registerSingletonWithDependencies<IDatabaseService>(() => FirebaseDatabaseService(), dependsOn: [IDeviceService]);
  GetIt.I.registerSingletonWithDependencies<IProductsRepository>(() => ProductsRepository(), dependsOn: [IDatabaseService, IDeviceService]);
}
