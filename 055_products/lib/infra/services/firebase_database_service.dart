// ignore_for_file: prefer_final_locals

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:products/domain/models/product_model.dart';
import 'package:products/domain/services/database_service.dart';
import 'package:products/domain/services/device_service.dart';
import 'package:products/domain/utils.dart';

class FirebaseDatabaseService implements IDatabaseService {
  FirebaseDatabaseService({IDeviceService? deviceService}) {
    this.deviceService = deviceService ?? GetIt.I.get<IDeviceService>();
  }

  late final IDeviceService deviceService;

  @override
  Future<void> delete(String id) async {
    await FirebaseFirestore.instance.collection(productsPath).doc(id).delete();
  }

  @override
  Future<void> deletePicture(String filename) async {
    try {
      log('Deleting picture $filename in device');
      final fullDevicePicturePath = await deviceService.getFullDevicePicturePath(filename);
      var picture = File(fullDevicePicturePath);
      await picture.delete();
    } on Exception catch (e, s) {
      log('Error when delete pictures on device.', error: e, stackTrace: s);
    }

    try {
      log('Deleting picture $filename in firebase');
      final firebasePicturePath = '$productsPath$filename';
      final ref = FirebaseStorage.instance.ref().child(firebasePicturePath);
      await ref.delete();
    } on Exception catch (e, s) {
      log('Error when delete pictures on firebase.', error: e, stackTrace: s);
    }
  }

  @override
  Future<List<ProductModel>> getAll() async {
    final collection = await FirebaseFirestore.instance.collection(productsPath).get();
    return collection.docs.map((snapshot) => ProductModel.fromMap(snapshot.id, snapshot.data())).toList();
  }

  @override
  Future<void> update(ProductModel productModel) async {
    await FirebaseFirestore.instance.collection(productsPath).doc(productModel.id).update(productModel.toMap(DateTime.now()));
  }

  @override
  Future<void> updatePicture(String filename, String oldFilename) async {
    try {
      var picture = File(await deviceService.getFullDevicePicturePath(filename));
      final imagePath = '$productsPath$filename';
      await FirebaseStorage.instance.ref(imagePath).putFile(picture);

      final oldImagePath = '$productsPath$oldFilename';
      await FirebaseStorage.instance.ref(oldImagePath).delete();
    } on FirebaseException catch (e, s) {
      log('Error when save picture on firebase.', error: e, stackTrace: s);
    }
  }

  @override
  Future<String> downloadPicture({required String filename}) async {
    try {
      final fullDevicePicturePath = await deviceService.getFullDevicePicturePath(filename);
      var picture = File(fullDevicePicturePath);

      if (!picture.existsSync()) {
        final firebasePicturePath = '$productsPath$filename';

        log('Downloading and saving picture on device: firebase($firebasePicturePath) device($fullDevicePicturePath)');
        final ref = FirebaseStorage.instance.ref().child(firebasePicturePath);
        await ref.writeToFile(picture);
      }
      return picture.path;
    } on Exception catch (e, s) {
      log('Error when downloads. Returns empty path.', error: e, stackTrace: s);
      return '';
    }
  }
}
