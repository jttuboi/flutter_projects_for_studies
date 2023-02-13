import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_teste_3_3_5/routes.dart';
import 'package:firebase_messaging_teste_3_3_5/service/notification_service.dart';

class FirebaseMessagingService {
  FirebaseMessagingService(this._notificationService);

  // para utilizar o firebase messaging, é OBRIGATÓRIO utilizar o notification service local
  final NotificationService _notificationService;

  Future<void> initialize() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );

    _getDeviceFirebaseToken();
    _onMessage();
    _onMessageOpenedApp();
  }

  Future<void> _getDeviceFirebaseToken() async {
    final settings = await FirebaseMessaging.instance.requestPermission();
    print(settings.authorizationStatus);

    // esse token é gerado especificamente para esse device
    // o ideal é que o token seja salvo em algum lugar, mais especificamente no backend,
    // pois assim ao ter esse token, o backend consegue enviar diretamente para esse device
    try {
      final token = await FirebaseMessaging.instance.getToken();
      print('TOKEENNNNN: $token');
    } catch (e) {
      print(e);
    }
  }

  // captura a notificação
  // quando o aplicativo está aberto
  // quando o aplicativo está aberto mas está em segundo plano (está minimizado)
  // quando o aplicativo está fechado

  // esse é quando o aplicativo está aberto
  Future<void> _onMessage() async {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      //AppleNotification? ios = message.notification?.apple;

      if (notification != null && android != null) {
        _notificationService.showNotification(CustomNotification(
          id: android.hashCode,
          title: notification.title,
          body: notification.body,
          payload: message.data['route'] ?? '',
        ));
      }
    });
  }

  // esse é quando o aplicativo está fechado
  Future<void> _onMessageOpenedApp() async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // nao esquecer da segurança (ver no notification service _onDidReceiveNotificationResponse())
      final route = message.data['route'] ?? '';
      if (route.isNotEmpty) {
        Routes.navigatorKey?.currentState?.pushNamed(route);
      }
    });
  }
}
