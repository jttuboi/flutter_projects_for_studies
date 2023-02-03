import 'package:flutter/material.dart';
import 'package:zendesk_messaging/zendesk_messaging.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String androidChannelKey = 'your android key';
  static const String iosChannelKey = 'your iOS key';

  final List<String> channelMessages = [];

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
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => ZendeskMessaging.initialize(
                    androidChannelKey: androidChannelKey,
                    iosChannelKey: iosChannelKey,
                  ),
                  child: const Text('Initialize'),
                ),
                if (isLogin) ...[
                  const ElevatedButton(
                    onPressed: ZendeskMessaging.show,
                    child: Text('Show messaging'),
                  ),
                  ElevatedButton(
                    onPressed: _getUnreadMessageCount,
                    child: Text('Get unread message count - $unreadMessageCount'),
                  ),
                ],
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: _logout,
                  child: const Text('Logout'),
                ),
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
      jwt: 'my_jwt',
      onSuccess: (id, externalId) => setState(() {
        channelMessages.add('Login observer - SUCCESS: $id, $externalId');
        isLogin = true;
      }),
      onFailure: () => setState(() {
        channelMessages.add('Login observer - FAILURE!');
        isLogin = false;
      }),
    );
  }

  void _logout() {
    ZendeskMessaging.logoutUser();
    setState(() {
      isLogin = false;
    });
  }

  Future<void> _getUnreadMessageCount() async {
    // final messageCount = await ZendeskMessaging.getUnreadMessageCount();
    // if (mounted) {
    //   unreadMessageCount = messageCount;
    //   setState(() {});
    // }
  }
}
