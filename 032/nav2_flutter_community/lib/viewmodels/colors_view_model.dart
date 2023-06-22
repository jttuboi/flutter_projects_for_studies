// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/data/colors_repository.dart';

class ColorsViewModel extends ChangeNotifier {
  ColorsViewModel(this.colorsRepository);

  final ColorsRepository? colorsRepository;
  bool fetchingColors = false;
  bool clearingColors = false;

  void fetchColors() async {
    fetchingColors = true;
    notifyListeners();
    await colorsRepository!.fetchColors();
    fetchingColors = false;
    notifyListeners();
  }

  void clearColors() async {
    clearingColors = true;
    notifyListeners();
    await colorsRepository!.clearColors();
    clearingColors = false;
    notifyListeners();
  }
}
