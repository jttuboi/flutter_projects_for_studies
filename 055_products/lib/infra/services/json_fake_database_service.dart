// ignore_for_file: prefer_final_locals

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:products/domain/models/product_model.dart';
import 'package:products/domain/services/database_service.dart';
import 'package:products/domain/services/device_service.dart';
import 'package:products/domain/utils.dart';

class JsonFakeDatabaseService implements IDatabaseService {
  JsonFakeDatabaseService(this.deviceService);

  final IDeviceService deviceService;

  @override
  Future<void> delete(String id) async {
    log('simulation: product(id: $id) deleted.');
  }

  @override
  Future<void> deletePicture(String filename) async {
    log('simulation: product image $filename deleted.');
  }

  @override
  Future<List<ProductModel>> getAll() async {
    final response = await rootBundle.loadString(jsonFakeDatabasePath);
    final jsonFile = json.decode(response) as List<dynamic>;

    return jsonFile.map<ProductModel>((jsonMap) => ProductModel.fromMap('fake id', jsonMap as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> update(ProductModel productModel) async {
    log('simulation: product with productModel = $productModel saved.');
  }

  @override
  Future<void> updatePicture(String filename, String oldFilename) async {
    log('simulation: product with filename($filename) saved and oldFilename($oldFilename).');
  }

  @override
  Future<String> downloadPicture({required String filename}) async {
    log('simulation: download picture.');
    try {
      final fullDevicePicturePath = await deviceService.getFullDevicePicturePath(filename);
      var picture = File(fullDevicePicturePath);

      if (!picture.existsSync()) {
        final assetsPicturePath = '$assetsImageFolderPath$filename';

        log('Converting and saving picture on device: assets($assetsPicturePath) device($fullDevicePicturePath)');
        final byteData = await rootBundle.load(assetsPicturePath);
        await picture.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      }
      return picture.path;
    } on Exception catch (e, s) {
      log('Error when adds to folder. Returns empty path.', error: e, stackTrace: s);
      return '';
    }
  }
}
