import 'dart:io';

import 'package:dio/dio.dart';

import '../exceptions/offline_exception.dart';

typedef FunctionRequestCallback = Future<Map<String, String>> Function();

typedef FunctionResponseCallback = Future<void> Function(Map<String, String> headers);

typedef FunctionErrorCallback = Future<void> Function(String errorData);

abstract interface class IHttpClientService {
  void init();

  void close();

  void setInterceptor({required FunctionRequestCallback onRequest, required FunctionResponseCallback onResponse, required FunctionErrorCallback onError});

  void addHeader(String key, {required String value});

  Future<Response> get(String url, {Map<String, dynamic> queryParameters = const {}, ResponseType responseType = ResponseType.json});

  Future<Response> post(String url, {Map<String, dynamic> queryParameters = const {}, ResponseType responseType = ResponseType.json, dynamic data});

  Future<Response> put(String url, {Map<String, dynamic> queryParameters = const {}, ResponseType responseType = ResponseType.json, dynamic data});

  Future<Response> patch(String url, {Map<String, dynamic> queryParameters = const {}, ResponseType responseType = ResponseType.json, dynamic data});

  Future<Response> delete(String url, {Map<String, dynamic> queryParameters = const {}, ResponseType responseType = ResponseType.json, dynamic data});
}

class DioService implements IHttpClientService {
  DioService();

  final _dio = Dio();

  @override
  void init() {}

  @override
  void close() {
    _dio.close();
  }

  @override
  void setInterceptor({required FunctionRequestCallback onRequest, required FunctionResponseCallback onResponse, required FunctionErrorCallback onError}) {}

  @override
  void addHeader(String key, {required String value}) {}

  @override
  Future<Response> get(String url, {Map<String, dynamic> queryParameters = const {}, ResponseType responseType = ResponseType.json}) async {
    // try {
    //   final result = await InternetAddress.lookup('google.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     print('a');
    //   }
    //   print('aa');
    // } on SocketException catch (_) {
    //   print('b');
    // }

    return _dio.get(url, queryParameters: queryParameters, options: Options(responseType: responseType)).catchError((error) {
      if (error is DioError && error.type == DioErrorType.unknown) {
        // normalmente são erros de internet (por exemplo osError.errorCode == 7 é a internet desligada)
        if (error.error is SocketException) {
          //} && (error.error! as SocketException).osError!.errorCode == 7) {
          throw OfflineException();
        }
      }
      throw error;
    });
  }

  @override
  Future<Response> post(String url, {Map<String, dynamic> queryParameters = const {}, ResponseType responseType = ResponseType.json, dynamic data}) async {
    throw UnimplementedError();
  }

  @override
  Future<Response> put(String url, {Map<String, dynamic> queryParameters = const {}, ResponseType responseType = ResponseType.json, dynamic data}) async {
    throw UnimplementedError();
  }

  @override
  Future<Response> patch(String url, {Map<String, dynamic> queryParameters = const {}, ResponseType responseType = ResponseType.json, dynamic data}) async {
    throw UnimplementedError();
  }

  @override
  Future<Response> delete(String url, {Map<String, dynamic> queryParameters = const {}, ResponseType responseType = ResponseType.json, dynamic data}) async {
    throw UnimplementedError();
  }
}
