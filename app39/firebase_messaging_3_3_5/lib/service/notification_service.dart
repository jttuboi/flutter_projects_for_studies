import 'package:firebase_messaging_teste_3_3_5/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class CustomNotification {
  const CustomNotification({
    required this.id,
    this.title,
    this.body,
    this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

class NotificationService {
  NotificationService() {
    _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initAndroidNotificationsDetails();
    _initNotifications();
  }

  late FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  late AndroidNotificationDetails _androidNotificationDetails;

  // versão que envia na hora
  void showNotification(CustomNotification notification) {
    _localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: _androidNotificationDetails,
        //ios...
      ),
      payload: notification.payload,
    );
  }

  // versão que envia depois de um tempo após a ativaçao da notificacao
  void showNotificationSchedule(CustomNotification notification, Duration duration) {
    final date = DateTime.now().add(duration);

    _localNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      tz.TZDateTime.from(date, tz.local),
      NotificationDetails(
        android: _androidNotificationDetails,
        //ios...
      ),
      payload: notification.payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // é chamado no inicio do app
  Future<void> checkForNotifications() async {
    final details = await _localNotificationsPlugin.getNotificationAppLaunchDetails();
    // verifica se tem uma notificaçao
    if (details != null && details.didNotificationLaunchApp) {
      // se tiver, abre a notification, nesse caso ele redireciona para página (ver dentro do método)
      _onDidReceiveNotificationResponse(details.notificationResponse!);
    }
  }

  Future<void> _initAndroidNotificationsDetails() async {
    _androidNotificationDetails = const AndroidNotificationDetails(
      'algum_id_pra_essa_notificacao',
      'Titulo do canal',
      channelDescription: 'este canal é pra lembretes',
      // a importance controla o tipo de notificaçao que será feito
      importance: Importance.max,
      // a priority controla se a próxima notificaçao emitida nesse canal será prioritário
      priority: Priority.max,
      enableVibration: true,
    );
  }

  Future<void> _initNotifications() async {
    // inicializa timezone e sincroniza de acordo com o timezone do celular
    tz.initializeTimeZones();
    final timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    // inicializa local notifications
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    // ios ...
    await _localNotificationsPlugin.initialize(
      const InitializationSettings(android: android),
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  void _onDidReceiveNotificationResponse(NotificationResponse details) {
    if (details.payload != null && details.payload!.isNotEmpty) {
      Navigator.of(Routes.navigatorKey!.currentContext!).pushNamed(details.payload!);
    }
  }
}
