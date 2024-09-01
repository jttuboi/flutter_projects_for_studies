import 'package:flutter/material.dart';

mixin CSnackBarMixin {
  void showSnackBarForSuccess(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Colors.green,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
    ));
  }

  void showSnackBarForWarning(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Colors.yellowAccent.shade400,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
    ));
  }

  void showSnackBarForError(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Colors.red.shade700,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      shape: const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
