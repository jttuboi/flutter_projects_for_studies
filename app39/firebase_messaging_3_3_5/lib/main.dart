// TODO readaptar o projeto pro
// o abaixo ele cria o projeto, mas tem q ver como associa com o projeto ja existente ou na conta
// q vc nao tem acesso

// precisa instalar o nodejs para utilizar o comando abaixo
// npm install -g firebase-tools

// para ativar o flutterfire client
// dart pub global activate flutterfire_cli

// para testar se está ok, utilizar o comando abaixo
// firebase --version
// flutterfire --version

// se estiver mostrando as versões e for a primeira vez q usa o firebase na sua máquina, utilizar o comando
// firebase login
// irá abrir o broswer e logar na conta em q utilizará o firebase

// para o código abaixo, já é necessário que tenha o projeto criado dentro do firebase, caso contrário não listará
// caso não tenha, entrar no https://console.firebase.google.com com a mesma conta utilizada no comando acima e
// criar o projeto pra ser utilizado neste projeto
//
// para listar os projetos do firebase, utilizar o comando
// flutterfire configure
// selecionar o projeto e escolher android e ios (obs: tem q estar na pagina do projeto flutter)
// nesse momento ele também perguntará se quer atualizar o seu projeto, clique yes.

// como instalar o flutterfire na sua máquina e associar no seu projeto
// https://www.youtube.com/watch?v=OjdGSoDntZQ
// como utilizar o local notifications no seu projeto
// https://www.youtube.com/watch?v=ilm89PL6-K8
// como utilizar o push notifications do firebase no seu projeto
// https://www.youtube.com/watch?v=jV8GsSl76FY

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging_teste_3_3_5/firebase_options.dart';
import 'package:firebase_messaging_teste_3_3_5/routes.dart';
import 'package:firebase_messaging_teste_3_3_5/service/firebase_messaging_service.dart';
import 'package:firebase_messaging_teste_3_3_5/service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // PRECISA DISSO, tanto pro local notifications quanto pro firebase messaging
  WidgetsFlutterBinding.ensureInitialized();

  // PRECISA DISSO, É AQUI Q É ASSOCIADO O FIREBASE COM SEU PROJETO
  await Firebase.initializeApp(
    // O firebase_options.dart foi gerado pelo comando `flutterfire configure`
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      Provider<NotificationService>(create: (_) => NotificationService()),
      Provider<FirebaseMessagingService>(create: (context) => FirebaseMessagingService(context.read<NotificationService>())),
    ],
    child: const App(),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _initilizeFirebaseMessaging();
    _checkNotifications();
  }

  Future<void> _initilizeFirebaseMessaging() async {
    await Provider.of<FirebaseMessagingService>(context, listen: false).initialize();
  }

  Future<void> _checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false).checkForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.list,
      initialRoute: Routes.initial,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
