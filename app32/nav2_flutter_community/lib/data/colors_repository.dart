import 'package:flutter/material.dart';

class ColorsRepository {
  /// Makes a fake call to cache that returns data after 3 seconds
  Future<List<Color>> fetchColors() async {
    return Future.delayed(Duration(seconds: 3)).then((value) {
      return Colors.primaries.reversed.toList();
    });
  }

  /// Makes a fake call to cache that returns data after 3 seconds
  Future<bool> clearColors() async {
    return Future.delayed(Duration(seconds: 3)).then((value) {
      return true;
    });
  }
}
