import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../entities/contact.dart';
import '../failures/empty_list_failure.dart';
import '../failures/internet_unavailable_failure.dart';
import '../failures/invalid_format_failure.dart';
import '../failures/no_service_found_failure.dart';
import '../failures/timeout_failure.dart';
import '../failures/unknown_failure.dart';
import '../services/result/result.dart';
import '../utils/logger.dart';
import 'contact_online_datasource.dart';

extension _IntExtension on int? {
  bool get is200ok => this == 200;
}

class DioContactOnlineDataSource implements IContactOnlineDataSource {
  DioContactOnlineDataSource({Dio? dio}) : _dio = dio ?? GetIt.I.get<Dio>();

  static const durationTimeout = Duration(seconds: 20);

  final Dio _dio;

  @override
  Future<Result<List<Contact>>> synchronize(List<Contact> contactsDesynchronized, Map<String, File> files) {
    Logger.pContactOnlineDataSource('synchronize', {'contactsDesynchronized': contactsDesynchronized});

    return _tryCatch<List<Contact>>(() async {
      //TODO tem um erro aqui, quando adiciona e nao existe nenhum avatar, dá nullpointer
      final formData = FormData.fromMap({
        'entities': contactsDesynchronized.map<Map<String, dynamic>>((contact) => contact.toMap()).toList(),
        'files': contactsDesynchronized
            .map<MultipartFile>((contact) => MultipartFile.fromBytes(
                      files[contact.id]!.readAsBytesSync(),
                      filename: contact.documentPhonePath.split('/').last,
                    )
                // MultipartFile.fromFileSync(
                //       contact.documentPhonePath,
                //       filename: contact.documentPhonePath.split('/').last,
                //     ),
                )
            .toList(),
      });

      final response = await _dio.put('/contacts', options: Options(contentType: Headers.multipartFormDataContentType), data: formData);
      // contactsDesynchronized.toEntitiesMap());

      if (response.statusCode.is200ok) {
        final maps = response.data['entities'] as List;

        if (maps.isEmpty) {
          return const Success(<Contact>[]);
        }

        return Success(
          maps.map<Contact>((map) => ContactExtension.fromMap(map)).toList(),
        );
      }
    });
  }

  @override
  Future<Result<bool>> hasDataToSynchronize() {
    Logger.pContactOnlineDataSource('hasDataToSynchronize');

    return _tryCatch<bool>(() async {
      final response = await _dio.get('/contacts/count').timeout(durationTimeout);

      if (response.statusCode.is200ok) {
        final count = response.data['count'] as int;

        return Success(count != 0);
      }
    });
  }

  @override
  Future<Result<List<Contact>>> getAll() async {
    Logger.pContactOnlineDataSource('getAll');

    return _tryCatch<List<Contact>>(() async {
      final response = await _dio.get('/contacts');

      if (response.statusCode.is200ok) {
        final maps = response.data['entities'] as List;

        if (maps.isEmpty) {
          return const Fail(EmptyListFailure());
        }

        return Success(
          maps.map<Contact>((map) => ContactExtension.fromMap(map)).toList(),
        );
      }
    });
  }

  Future<Result<R>> _tryCatch<R>(Future<Result<R>?> Function() runContent, {Future<Result<R>?> Function(DioError error)? runDioError}) async {
    try {
      final result = await runContent();
      if (result != null) {
        return result;
      }
    } on TimeoutException {
      return const Fail(TimeoutFailure());
    } on SocketException {
      return const Fail(InternetUnavailableFailure());
    } on HttpException {
      return const Fail(NoServiceFoundFailure());
    } on FormatException {
      return const Fail(InvalidFormatFailure());
    } on DioError catch (error) {
      if (runDioError != null) {
        final resultError = await runDioError(error);
        if (resultError != null) {
          return resultError;
        }
      }
    }
    return const Fail(UnknownFailure());
  }
}

  // @override
  // Future<Result<({List<Contact> contacts, Meta meta})>> getAll({int page = 0}) async {
  //   return _tryCatch<({List<Contact> contacts, Meta meta})>(() async {
  //     final response = await _dio.get('/contacts', queryParameters: {
  //       'page': page,
  //     });

  //     if (response.statusCode.is200ok) {
  //       final maps = response.data['entities'] as List;

  //       if (maps.isEmpty) {
  //         return const Fail(EmptyListFailure());
  //       }

  //       final meta = response.data['meta'];

  //       return Success((
  //         contacts: maps.map<Contact>((map) => Contact.fromMap(map)).toList(),
  //         meta: Meta.fromMap(meta),
  //       ));
  //     }
  //   });
  // }

  // @override
  // Future<Result<void>> deleteAll() async {
  //   return _tryCatch(() async {
  //     final response = await _dio.delete('/contacts').timeout(durationTimeout);

  //     if (response.statusCode.is204noContent) {
  //       return const Success(null);
  //     }
  //   });
  // }

  // @override
  // Future<Result<Contact>> get(String id) async {
  //   return _tryCatch<Contact>(() async {
  //     final response = await _dio.get('/contacts/$id').timeout(durationTimeout);

  //     if (response.statusCode.is200ok) {
  //       final map = response.data['entity'] as Map<String, dynamic>;

  //       if (map.isEmpty) {
  //         return const Fail(EmptyEntityFailure());
  //       }

  //       return Success(Contact.fromMap(map));
  //     }
  //   }, runDioError: (error) async {
  //     if (error.response!.statusCode.is404notFound) {
  //       return const Fail(EmptyEntityFailure());
  //     }
  //   });
  // }

  // @override
  // Future<Result<Contact>> create(Contact contactToAdd) async {
  //   return _tryCatch<Contact>(() async {
  //     final formData = FormData.fromMap({
  //       ...contactToAdd.toMap(),
  //       if (contactToAdd.avatarPhonePath.isNotEmpty) ...{
  //         'avatarFile': await MultipartFile.fromFile(contactToAdd.avatarPhonePath, filename: 'avatar.png'),
  //       },
  //       if (contactToAdd.documentPhonePath.isNotEmpty) ...{
  //         'documentFile': await MultipartFile.fromFile(contactToAdd.documentPhonePath, filename: 'avatar.png'),
  //       },
  //     });

  //     final response = await _dio.post('/contacts', data: formData).timeout(durationTimeout);

  //     if (response.statusCode.is201created) {
  //       final map = response.data['entity'] as Map<String, dynamic>;

  //       if (map.isEmpty) {
  //         return const Fail(EmptyEntityFailure());
  //       }

  //       return Success(Contact.fromMap(map));
  //     }
  //   });
  // }

  // @override
  // Future<Result<Contact>> update(Contact contactToEdit) async {
  //   return _tryCatch<Contact>(() async {
  //     final formData = FormData.fromMap({
  //       ...contactToEdit.toMap(),
  //       if (contactToEdit.avatarPhonePath.isNotEmpty) ...{
  //         'avatarFile': await MultipartFile.fromFile(contactToEdit.avatarPhonePath, filename: 'avatar.png'),
  //       },
  //       if (contactToEdit.documentPhonePath.isNotEmpty) ...{
  //         'documentFile': await MultipartFile.fromFile(contactToEdit.documentPhonePath, filename: 'avatar.png'),
  //       },
  //     });

  //     final response = await _dio.put('/contacts/${contactToEdit.id}', data: formData).timeout(durationTimeout);

  //     if (response.statusCode.is200ok) {
  //       final map = response.data['entity'] as Map<String, dynamic>;

  //       if (map.isEmpty) {
  //         return const Fail(EmptyEntityFailure());
  //       }

  //       return Success(Contact.fromMap(map));
  //     }
  //   }, runDioError: (error) async {
  //     if (error.response!.statusCode.is404notFound) {
  //       return const Fail(EmptyEntityFailure());
  //     }
  //   });
  // }

  // @override
  // Future<Result<void>> delete(Contact contactToRemove) async {
  //   return _tryCatch(() async {
  //     final response = await _dio.get('/contacts/${contactToRemove.id}').timeout(durationTimeout);

  //     if (response.statusCode.is204noContent) {
  //       return const Success(null);
  //     }
  //   });
  // }
