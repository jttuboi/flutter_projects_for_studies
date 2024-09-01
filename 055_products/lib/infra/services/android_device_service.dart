import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:products/domain/services/device_service.dart';
import 'package:products/domain/utils.dart';

class AndroidDeviceService implements IDeviceService {
  @override
  Future<String> getProductsDeviceFolderPath() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final productDir = Directory('${appDocDir.path}/$productsPath');

    if (!productDir.existsSync()) {
      log('Creating folder products on device');
      productDir.createSync();
    }

    return productDir.path;
  }

  @override
  Future<String> getFullDevicePicturePath(String filename) async {
    return '${await getProductsDeviceFolderPath()}$filename';
  }

  @override
  Future<String> createPictureOnProductsDeviceFolder(String picturePath) async {
    final filename = basename(picturePath);
    final fullDevicePicturePath = await getFullDevicePicturePath(filename);

    await File(picturePath).copy(fullDevicePicturePath);

    return fullDevicePicturePath;
  }
}
