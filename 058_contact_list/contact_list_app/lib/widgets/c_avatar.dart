import 'dart:io';

import 'package:flutter/material.dart';

import 'c_default_avatar.dart';

class CAvatar extends StatelessWidget {
  const CAvatar(this.avatarFile, {this.size = 100, super.key});

  final File? avatarFile;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (avatarFile == null) {
      return CDefaultAvatar(size: size);
    }

    return Image.file(avatarFile!, width: size, height: size, errorBuilder: (_, __, ___) {
      return CDefaultAvatar(size: size);
    });
  }
}
