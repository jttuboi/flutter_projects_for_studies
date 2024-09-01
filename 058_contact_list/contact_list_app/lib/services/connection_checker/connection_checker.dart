import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract interface class IMyConnectionChecker extends ValueNotifier<bool> {
  IMyConnectionChecker() : super(true);

  Future<void> init();

  @override
  void dispose();

  bool get hasConnection;
}

class MyInternetConnectionChecker extends ValueNotifier<bool> implements IMyConnectionChecker {
  MyInternetConnectionChecker() : super(true);

  late final InternetConnectionChecker _internetConnectionChecker;

  late final StreamSubscription<InternetConnectionStatus> _connectionListener;

  @override
  Future<void> init() async {
    _internetConnectionChecker = InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 1),
      checkInterval: const Duration(seconds: 1),
    );

    // checa e seta o primeiro status do notifier
    value = await _internetConnectionChecker.hasConnection;

    // cria um listener para checar de tempos em tempos se a conexão está viva
    _connectionListener = _internetConnectionChecker.onStatusChange.listen((status) {
      value = (status == InternetConnectionStatus.connected);
    });
  }

  @override
  void dispose() {
    _connectionListener.cancel();
    super.dispose();
  }

  @override
  bool get hasConnection => value;
}
