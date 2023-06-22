import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:sqflite_test/shared/styles.dart';

class ContactDetailsImage extends StatelessWidget {
  const ContactDetailsImage({required this.image, Key? key}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: basePrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(200),
      ),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(File(image)),
          ),
        ),
      ),
    );
  }
}
