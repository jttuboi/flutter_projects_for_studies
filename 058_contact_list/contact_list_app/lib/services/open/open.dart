import 'package:open_filex/open_filex.dart';

class Open {
  const Open._();

  static Future<OpenResult> pdf({required String phonePath}) async {
    return OpenFilex.open(phonePath, type: 'application/pdf');
  }
}
