import 'package:firebase_messaging_teste_3_3_5/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _rememberLater = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          ListTile(
            title: const Text('Lembrar-me mais tarde'),
            trailing: _rememberLater ? Icon(Icons.check_box, color: Colors.amber.shade600) : const Icon(Icons.check_box_outline_blank),
            onTap: _showNotification,
          ),
        ],
      ),
    );
  }

  void _showNotification() {
    setState(() {
      _rememberLater = !_rememberLater;
      if (_rememberLater) {
        Provider.of<NotificationService>(context, listen: false).showNotification(const CustomNotification(
          id: 1,
          title: 'BlaBla titulo',
          body: 'blabla descricao da notificacao',
          payload: '/notificacao',
        ));
      }
    });
  }
}
