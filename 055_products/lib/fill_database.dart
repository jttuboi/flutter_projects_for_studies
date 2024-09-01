// ignore_for_file: prefer_final_locals

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:products/domain/models/product_model.dart';
import 'package:products/domain/utils.dart';
import 'package:products/infra/services/android_device_service.dart';

Future<void> fillDatabase() async {
  log('==== INICIOU ENVIO DE DADOS PARA FIREBASE ====');
  // limpa firebase
  try {
    final collection = await FirebaseFirestore.instance.collection(productsPath).get();
    for (final doc in collection.docs) {
      await doc.reference.delete();
    }
    final ref = FirebaseStorage.instance.ref(productsPath);
    final pictures = await ref.listAll();
    for (final picture in pictures.items) {
      await picture.delete();
    }
  } on FirebaseException catch (e, s) {
    log('erro ao deletar algum item do firebase', error: e, stackTrace: s);
    return;
  }

  var jsonProducts = <ProductModel>[];

  // le os dados do arquivo json
  try {
    final response = await rootBundle.loadString(jsonFakeDatabasePath);
    final jsonFile = json.decode(response) as List<dynamic>;
    jsonProducts = jsonFile.map<ProductModel>((jsonMap) => ProductModel.fromMap('fake id', jsonMap as Map<String, dynamic>)).toList();
  } on Exception catch (e, s) {
    log('erro na leitura do arquivo json', error: e, stackTrace: s);
    return;
  }

  // adiciona os dados no firebase
  try {
    for (final jsonProduct in jsonProducts) {
      // adiciona os dados
      log('adicionando ${jsonProduct.title}');
      await FirebaseFirestore.instance.collection(productsPath).add(jsonProduct.toMap(DateTime.now()));

      // cria o file temporario da imagem no device
      final tempImagePath = await AndroidDeviceService().getFullDevicePicturePath(jsonProduct.filename);
      log('criando imagem $tempImagePath');
      var picture = File(tempImagePath);
      final byteData = await rootBundle.load('$assetsImageFolderPath${jsonProduct.filename}');
      await picture.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      // adiciona a imagem no firebase
      final imagePath = '$productsPath${jsonProduct.filename}';
      log('adicionando imagem $imagePath');
      await FirebaseStorage.instance.ref(imagePath).putFile(picture);

      // deleta o temporario depois de adicionar
      await picture.delete();
    }
  } on Exception catch (e, s) {
    log('erro em algum momento de enviar os dados', error: e, stackTrace: s);
    return;
  }
  log('==== FINALIZOU COM SUCESSO ====');
}
