import 'dart:io';

abstract class IConverterImageToTextService {
  Future<String> convert(File image);
}
