import 'package:flutter/material.dart';

// este é o tema default, mas pode virar o principal do app caso só seja app de 1 tema.
// o bom de ter essa estrutura é que futuramente pode ser expandido para aceitar outros temas caso necessário.

class ThemeStyles {
  const ThemeStyles();

  AppColors get appColors => AppColors(primary: Colors.red.shade300, secondary: Colors.red.shade100);

  AppColors get appColorsDark => AppColors(primary: Colors.red.shade900, secondary: Colors.red.shade700);

  AppTextStyles get appTextStyles => const AppTextStyles(ui10: TextStyle(), ui12: TextStyle());

  AppTextStyles get appTextStylesDark => const AppTextStyles(ui10: TextStyle(), ui12: TextStyle());
}

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.secondary,
  });

  final Color? primary;
  final Color? secondary;

  @override
  AppColors copyWith({
    Color? primary,
    Color? secondary,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      primary: Color.lerp(primary, other.primary, t),
      secondary: Color.lerp(secondary, other.secondary, t),
    );
  }
}

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.ui10,
    required this.ui12,
  });

  final TextStyle? ui10;
  final TextStyle? ui12;

  @override
  AppTextStyles copyWith({
    TextStyle? ui10,
    TextStyle? ui12,
  }) {
    return AppTextStyles(
      ui10: ui10 ?? this.ui10,
      ui12: ui12 ?? this.ui12,
    );
  }

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;

    return AppTextStyles(
      ui10: TextStyle.lerp(ui10, other.ui10, t),
      ui12: TextStyle.lerp(ui12, other.ui12, t),
    );
  }
}
