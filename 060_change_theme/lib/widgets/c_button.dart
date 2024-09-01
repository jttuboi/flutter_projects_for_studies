import 'package:flutter/material.dart';
import 'package:teste_tema_independente/themes/theme_styles.dart';

import '../utils.dart';

class CButton extends StatelessWidget {
  const CButton(this.data, {this.style = const CButtonStylePrimary(), this.isEnabled = true, this.onPressed = function, super.key});

  final CButtonData data;
  final ICButtonStyle style;
  final bool isEnabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: style.padding,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        child: Container(
          height: 51,
          color: style.backgroundColor(context, isEnabled: isEnabled),
          child: Row(
            children: [
              Icon(Icons.abc, color: style.iconColor(context)),
              const SizedBox(width: 8),
              Text(data.label, textAlign: TextAlign.center, style: style.labelTextStyle(context, isEnabled: isEnabled))
            ],
          ),
        ),
      ),
    );
  }
}

final class CButtonData {
  const CButtonData(this.label);

  final String label;
}

abstract class ICButtonStyle {
  const ICButtonStyle({this.isFilled = true, this.padding = EdgeInsets.zero});

  final bool isFilled;
  final EdgeInsets padding;

  Color? iconColor(BuildContext context);

  Color? backgroundColor(BuildContext context, {required bool isEnabled});

  TextStyle? labelTextStyle(BuildContext context, {required bool isEnabled});
}

class CButtonStylePrimary extends ICButtonStyle {
  const CButtonStylePrimary({super.isFilled, super.padding = EdgeInsets.zero});

  @override
  Color? iconColor(BuildContext context) {
    return context.theme<AppColors>()?.secondary;
  }

  @override
  Color? backgroundColor(BuildContext context, {required bool isEnabled}) {
    if (isFilled && isEnabled) {
      return context.theme<AppColors>()?.primary;
    } else //
    if (isFilled && !isEnabled) {
      return Colors.grey.shade400;
    } else //
    if (!isFilled && isEnabled) {
      return Colors.grey.shade100;
    } else //
    if (!isFilled && !isEnabled) {
      return Colors.grey.shade200;
    }

    return null; // nunca irá chegar aqui, apenas para evitar lint
  }

  @override
  TextStyle? labelTextStyle(BuildContext context, {required bool isEnabled}) {
    if (isFilled && isEnabled) {
      return context.theme<AppTextStyles>()?.ui10?.copyWith(color: Colors.white);
    } else //
    if (isFilled && !isEnabled) {
      return context.theme<AppTextStyles>()?.ui10?.copyWith(color: Colors.grey.shade200);
    } else //
    if (!isFilled && isEnabled) {
      return context.theme<AppTextStyles>()?.ui12?.copyWith(color: context.theme<AppColors>()?.primary);
    } else //
    if (!isFilled && !isEnabled) {
      return context.theme<AppTextStyles>()?.ui12?.copyWith(color: Colors.grey.shade500);
    }

    return null; // nunca irá chegar aqui, apenas para evitar lint
  }
}

class CButtonStyleSecondary extends ICButtonStyle {
  const CButtonStyleSecondary({super.isFilled, super.padding = EdgeInsets.zero});

  @override
  Color? iconColor(BuildContext context) {
    return Colors.pink;
  }

  @override
  Color? backgroundColor(BuildContext context, {required bool isEnabled}) {
    if (isFilled && isEnabled) {
      return context.theme<AppColors>()?.secondary;
    } else //
    if (isFilled && !isEnabled) {
      return Colors.grey.shade400;
    } else //
    if (!isFilled && isEnabled) {
      return Colors.grey.shade100;
    } else //
    if (!isFilled && !isEnabled) {
      return Colors.grey.shade200;
    }

    return null; // nunca irá chegar aqui, apenas para evitar lint
  }

  @override
  TextStyle? labelTextStyle(BuildContext context, {required bool isEnabled}) {
    if (isFilled && isEnabled) {
      return context.theme<AppTextStyles>()?.ui10?.copyWith(color: Colors.white);
    } else //
    if (isFilled && !isEnabled) {
      return context.theme<AppTextStyles>()?.ui10?.copyWith(color: Colors.grey.shade200);
    } else //
    if (!isFilled && isEnabled) {
      return context.theme<AppTextStyles>()?.ui12?.copyWith(color: context.theme<AppColors>()?.primary);
    } else //
    if (!isFilled && !isEnabled) {
      return context.theme<AppTextStyles>()?.ui12?.copyWith(color: Colors.grey.shade500);
    }

    return null; // nunca irá chegar aqui, apenas para evitar lint
  }
}

// também dá pra extender do CButtonStylePrimary para evitar reescrever, apenas modificando com override

class CButtonStyleTertiary extends CButtonStylePrimary {
  const CButtonStyleTertiary({super.isFilled, super.padding = EdgeInsets.zero});

  @override
  Color? iconColor(BuildContext context) {
    return Colors.black;
  }
}
