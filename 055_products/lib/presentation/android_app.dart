import 'package:flutter/material.dart';
import 'package:products/presentation/product_form/pages/product_form_page.dart';
import 'package:products/presentation/products/pages/products_page.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Colors.deepPurple,
        ),
        inputDecorationTheme: const InputDecorationTheme().copyWith(
          labelStyle: const TextStyle().copyWith(color: Colors.deepPurple),
          focusedBorder: const UnderlineInputBorder().copyWith(
            borderSide: const BorderSide().copyWith(color: Colors.deepPurple),
          ),
        ),
        iconTheme: const IconThemeData().copyWith(color: Colors.grey),
        colorScheme: const ColorScheme.light().copyWith(primary: Colors.deepPurple),
      ),
      onGenerateRoute: (settings) {
        if (settings.name == ProductsPage.routeName) {
          return ProductsPage.route();
        }
        if (settings.name == ProductFormPage.routeName) {
          return ProductFormPage.route(settings.arguments! as String);
        }
      },
    );
  }
}
