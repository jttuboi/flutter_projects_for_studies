import 'package:flutter/material.dart';

class NotificacaoPage extends StatelessWidget {
  const NotificacaoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificacao')),
      body: Column(
        children: const [
          Icon(Icons.message_outlined, size: 48),
          Text('Novidades após notificaçao push', style: TextStyle(fontSize: 18)),
          Center(child: Text('notificacao')),
        ],
      ),
    );
  }
}
