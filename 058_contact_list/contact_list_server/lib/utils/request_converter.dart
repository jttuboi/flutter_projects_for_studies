import 'dart:convert';
import 'dart:developer';

import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/form_data.dart';

class RequestConverter {
  const RequestConverter._();

  static Future<Map<String, dynamic>?> formData(Request request) async {
    try {
      final fields = <String, Map<String, String>>{};
      final files = <String, dynamic>{};

      final formsData = await request.multipartFormData.toList();
      //log(formsData.toString());

      for (final formData in formsData) {
        //log('aaa ${formData.name}');
        //log('bbb ${formData.filename ?? ''}');
        //log('ccc ${formData.part.headers}');
        //log('ddd ${formData.part}');

        if (formData.name.contains('entities')) {
          final strings = formData.name.split('[');
          final index = strings[1].replaceAll(']', '');
          final field = strings[2].replaceAll(']', '');

          final content = await formData.part.readString();

          if (!fields.containsKey(index)) {
            fields[index] = <String, String>{};
          }

          fields[index]![field] = content;
        } else if (formData.name.contains('files')) {
          final name = formData.name;
          print(name);
          final filename = formData.filename;
          print(filename);
          final file = await formData.part.readBytes();
          print(file);
        }

        // if (formData.filename == null) {
        //   final dataString = await formData.part.readString();
        //   fields[formData.name] = jsonDecode(dataString) ?? dataString;
        // } else if (formData.filename is String) {
        //   files[formData.name] = await formData.part.readBytes();
        // }
      }

      log(const JsonEncoder.withIndent(' ').convert(fields));

      return {
        'fields': fields,
        'files': files,
      };
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
