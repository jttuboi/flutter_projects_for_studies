import 'package:flutter/material.dart' as m;
import 'package:teste_tema_independente/themes/theme_styles.dart';
import 'package:teste_tema_independente/utils.dart';

class DialogData {
  const DialogData({
    this.barrierDismissible = true,
    this.barrierColor,
    this.barrierLabel,
    this.useSafeArea = true,
    this.useRootNavigator = true,
    this.routeSettings,
    this.anchorPoint,
    this.traversalEdgeBehavior,
  });

  final bool barrierDismissible;
  final m.Color? barrierColor;
  final String? barrierLabel;
  final bool useSafeArea;
  final bool useRootNavigator;
  final m.RouteSettings? routeSettings;
  final m.Offset? anchorPoint;
  final m.TraversalEdgeBehavior? traversalEdgeBehavior;
}

class GM {
  const GM._();

  static final m.GlobalKey<m.NavigatorState> navigatorKey = m.GlobalKey<m.NavigatorState>();

  static Future<T?> showDialog<T>(DialogData data, {required m.Widget Function(m.BuildContext context) builder}) async {
    assert(navigatorKey.currentContext != null, 'asdasd');

    return m.showDialog<T>(
      context: navigatorKey.currentContext!,
      barrierDismissible: data.barrierDismissible,
      barrierColor: data.barrierColor,
      barrierLabel: data.barrierLabel,
      useSafeArea: data.useSafeArea,
      useRootNavigator: data.useRootNavigator,
      routeSettings: data.routeSettings,
      anchorPoint: data.anchorPoint,
      traversalEdgeBehavior: data.traversalEdgeBehavior,
      builder: builder,
    );
  }
}

class CDialog extends m.StatelessWidget {
  const CDialog(this.data, {this.style = const CButtonStyle(), super.key});

  final CDialogData data;
  final ICDialogStyle style;

  @override
  m.Widget build(m.BuildContext context) {
    return m.AlertDialog(
      title: m.Text(data.title),
      content: m.Text(data.text),
      backgroundColor: style.backgroundColor(context),
    );
  }
}

class CDialogData {
  const CDialogData({required this.title, required this.text});

  final String title;
  final String text;
}

abstract class ICDialogStyle {
  const ICDialogStyle();

  m.Color? backgroundColor(m.BuildContext context);
}

class CButtonStyle extends ICDialogStyle {
  const CButtonStyle();

  @override
  m.Color? backgroundColor(m.BuildContext context) {
    return context.theme<AppColors>()?.primary;
  }
}
