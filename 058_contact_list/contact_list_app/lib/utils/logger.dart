import 'dart:developer';

class Logger {
  factory Logger() => _instance;
  const Logger._();
  static const _instance = Logger._();

  static bool activateLogger = false;

  static void p(String data) {
    if (activateLogger) {
      log(data);
    }
  }

  static void pContactsCubit(String methodName, [Map<String, dynamic>? parameters]) {
    _defaultLog('ContactsCubit', methodName, parameters);
  }

  static void pContactCubit(String methodName, [Map<String, dynamic>? parameters]) {
    _defaultLog('ContactCubit', methodName, parameters);
  }

  static void pContactRepository(String methodName, [Map<String, dynamic>? parameters]) {
    _defaultLog('ContactRepository', methodName, parameters);
  }

  static void pContactOfflineDataSource(String methodName, [Map<String, dynamic>? parameters]) {
    _defaultLog('ContactOfflineDataSource', methodName, parameters);
  }

  static void pContactOnlineDataSource(String methodName, [Map<String, dynamic>? parameters]) {
    _defaultLog('ContactOnlineDataSource', methodName, parameters);
  }

  static void _defaultLog(String className, String methodName, [Map<String, dynamic>? parameters]) {
    if (activateLogger) {
      log('=== $className.$methodName(${_toParametersString(parameters)})');
    }
  }

  static String _toParametersString(Map<String, dynamic>? parameters) {
    if (parameters == null) {
      return '';
    }

    final str = StringBuffer();
    final entries = parameters.entries;
    final last = parameters.entries.last;
    for (final entry in entries) {
      final name = entry.key;
      final data = entry.value;
      str.write('$name: $data');

      if (entry.key != last.key) {
        str.write(', ');
      }
    }
    return str.toString();
  }
}
