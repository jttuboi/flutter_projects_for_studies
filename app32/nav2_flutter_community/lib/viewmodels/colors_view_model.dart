// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/data/colors_repository.dart';

class ColorsViewModel extends ChangeNotifier {
  ColorsViewModel(this.colorsRepository);

  final ColorsRepository? colorsRepository;
  bool _fetchingColors = false;
  bool _clearingColors = false;

  void fetchColors() async {
    _fetchingColors = true;
    notifyListeners();
    await colorsRepository!.fetchColors();
    _fetchingColors = false;
    notifyListeners();
  }

  void clearColors() async {
    _clearingColors = true;
    notifyListeners();
    await colorsRepository!.clearColors();
    _clearingColors = false;
    notifyListeners();
  }
}
