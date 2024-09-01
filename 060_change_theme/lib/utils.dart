import 'package:flutter/material.dart';

void function() {}

extension BuildContextExtension on BuildContext {
  T? theme<T>() {
    return Theme.of(this).extension<T>();
  }
}
