import 'package:flutter/material.dart';
import 'package:teste_tema_independente/themes/theme_styles.dart';

class ThemeStyles2 implements ThemeStyles {
  const ThemeStyles2();

  @override
  AppColors get appColors => AppColors(primary: Colors.blue.shade300, secondary: Colors.blue.shade100);

  @override
  AppColors get appColorsDark => AppColors(primary: Colors.blue.shade900, secondary: Colors.blue.shade700);

  @override
  AppTextStyles get appTextStyles => const AppTextStyles(ui10: TextStyle(), ui12: TextStyle());

  @override
  AppTextStyles get appTextStylesDark => const AppTextStyles(ui10: TextStyle(), ui12: TextStyle());
}
