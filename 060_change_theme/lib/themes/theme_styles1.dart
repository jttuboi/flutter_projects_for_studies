import 'package:flutter/material.dart';
import 'package:teste_tema_independente/themes/theme_styles.dart';

class ThemeStyles1 extends ThemeStyles {
  const ThemeStyles1();

  @override
  AppColors get appColors => AppColors(primary: Colors.green.shade300, secondary: Colors.green.shade100);

  @override
  AppColors get appColorsDark => AppColors(primary: Colors.green.shade900, secondary: Colors.green.shade700);

  @override
  AppTextStyles get appTextStyles => const AppTextStyles(ui10: TextStyle(), ui12: TextStyle());

  @override
  AppTextStyles get appTextStylesDark => const AppTextStyles(ui10: TextStyle(), ui12: TextStyle());
}
