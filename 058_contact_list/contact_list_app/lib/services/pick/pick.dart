import 'package:file_picker/file_picker.dart';

class Pick {
  const Pick._();

  static Future<String> image() async {
    final f = await FilePicker.platform.pickFiles(type: FileType.image);
    return f?.paths.first ?? '';
  }

  static Future<String> pdf() async {
    final f = await FilePicker.platform.pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
    return f?.paths.first ?? '';
  }
}
