import 'package:flutter/material.dart';

class CDefaultAvatar extends StatelessWidget {
  const CDefaultAvatar({required this.size, super.key}) : assert(size > 10, 'size must be greater than 10.');

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      width: size,
      height: size,
      child: Icon(Icons.person, size: size - 10, color: Colors.grey),
    );
  }
}
