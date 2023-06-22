import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketService {
  late IOWebSocketChannel websocket;

  Future initConnection() async {
    websocket = IOWebSocketChannel.connect(
      'ws://cryptic-journey-23330.herokuapp.com/',
      pingInterval: const Duration(seconds: 5),
    );
  }

  Future disconnect() async {
    await websocket.sink.close();
  }

  Future _retryConnection({
    required void Function(Map<String, dynamic>) onReceive,
  }) async {
    await Future.delayed(const Duration(seconds: 5));
    await initConnection();
    await broadcastNotifications(
      onReceive: onReceive,
    );
  }

  Future broadcastNotifications({
    required void Function(Map<String, dynamic>) onReceive,
  }) async {
    websocket.stream.listen(
      (event) {
        try {
          final Map<String, dynamic> json = jsonDecode(event);
          onReceive(json);
        } on Exception {
          debugPrint('Error do Hello World');
        }
      },
      onError: (_) async {
        _retryConnection(onReceive: onReceive);
      },
      onDone: () async {
        _retryConnection(onReceive: onReceive);
      },
      cancelOnError: true,
    );
  }

  void sendMessage(Map<String, dynamic> action) {
    websocket.sink.add(jsonEncode(action));
  }
}
