import 'dart:ui';

extension OffsetExtension on Offset {
  static Offset fromSize(Size size) => Offset(size.width, size.height);
}
