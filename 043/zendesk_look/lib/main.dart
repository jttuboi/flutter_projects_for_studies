import 'package:flutter/material.dart';
import 'package:zendesk_messaging/zendesk_messaging.dart';

import 'dados_importantes.dart';

// https://pub.dev/packages/zendesk_messaging
// https://dev.to/gikwegbu/integrating-zendesk-with-flutter-2jol

// criar o arquivo dados_importantes.dart e adicionar as linhas abaixo:
//
//   // https://XXXXXXXXX.zendesk.com/admin/channels/messaging_and_social/channels_list
//   const androidChannelKey = 'your android key';
//   const iosChannelKey = 'your iOS key';
//   // https://XXXXXXXXX.zendesk.com/admin/account/security/end_users#messaging
//   const jwt = '';

// para gerar o JWT caso queira passar os dados sem a necessidade de perguntar
// https://developer.zendesk.com/documentation/zendesk-web-widget-sdks/sdks/web/enabling_auth_visitors/

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final channelMessages = <String>[];

  bool isLogin = false;
  int unreadMessageCount = 0;

  @override
  void initState() {
    super.initState();
    // Optional, observe all incoming messages
    ZendeskMessaging.setMessageHandler((type, arguments) {
      setState(() {
        channelMessages.add('$type - args=$arguments');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final message = channelMessages.join('\n');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Zendesk Messaging Example'),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Text(message),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () => ZendeskMessaging.initialize(
                          androidChannelKey: androidChannelKey,
                          iosChannelKey: iosChannelKey,
                        ),
                    child: const Text('Initialize')),
                if (isLogin) ...[
                  const ElevatedButton(onPressed: ZendeskMessaging.show, child: Text('Show messaging')),
                  ElevatedButton(onPressed: _getUnreadMessageCount, child: Text('Get unread message count - $unreadMessageCount')),
                ],
                ElevatedButton(onPressed: _login, child: const Text('Login')),
                ElevatedButton(onPressed: _logout, child: const Text('Logout')),
                // const ElevatedButton(onPressed: ZendeskMessaging.show, child: Text('Show messaging without JWT')),
                // const ElevatedButton(onPressed: getJWT, child: Text('JWT')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    // You can attach local observer when calling some methods to be notified when ready
    ZendeskMessaging.loginUserCallbacks(
      jwt: jwt,
      onSuccess: (id, externalId) => setState(() {
        channelMessages.add('Login observer - SUCCESS: $id, $externalId');
        isLogin = true;
      }),
      onFailure: () => setState(() {
        channelMessages.add('Login observer - FAILURE!');
        isLogin = false;
      }),
    );

    // // Method 1
    // final ZendeskLoginResponse result = await ZendeskMessaging.loginUser(jwt: "YOUR_JWT");
    // await ZendeskMessaging.logoutUser();

    // // Method 2 if you need callbacks
    // await ZendeskMessaging.loginUserCallbacks(jwt: "YOUR_JWT", onSuccess: (id, externalId) => ..., onFailure: () => ...;
    // await ZendeskMessaging.logoutUserCallbacks(onSuccess: () => ..., onFailure: () => ...);
  }

  void _logout() {
    ZendeskMessaging.logoutUser();
    setState(() {
      isLogin = false;
    });
  }

  Future<void> _getUnreadMessageCount() async {
    // final messageCount = await ZendeskMessaging.getUnreadMessageCount()();
    // if (mounted) {
    //   unreadMessageCount = messageCount;
    //   setState(() {});
    // }
  }
}
