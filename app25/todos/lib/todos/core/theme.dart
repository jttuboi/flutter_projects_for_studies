import 'package:flutter/material.dart';

class Themes {
  Themes._();

  static ThemeData get theme {
    final themeData = ThemeData.dark();
    final textTheme = themeData.textTheme;
    final bodyText1 = textTheme.bodyText1!.copyWith(decorationColor: Colors.transparent);

    return ThemeData.dark().copyWith(
      primaryColor: Colors.grey[800],
      colorScheme: themeData.colorScheme.copyWith(secondary: Colors.cyan[300]),
      buttonTheme: themeData.buttonTheme.copyWith(buttonColor: Colors.grey[800]),
      textSelectionTheme: themeData.textSelectionTheme.copyWith(selectionColor: Colors.cyan[100]),
      toggleableActiveColor: Colors.cyan[300],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.cyan[300],
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: themeData.dialogBackgroundColor,
        contentTextStyle: bodyText1,
        actionTextColor: Colors.cyan[300],
      ),
      textTheme: textTheme.copyWith(bodyText1: bodyText1),
    );
  }
}
