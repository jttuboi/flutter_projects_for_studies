import 'package:flutter/material.dart';
import 'package:semana_do_flutter_gerencia_estado_redux/redux/app_store.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  // esses são os códigos antigos que o valor era armazenado diretamente aqui na view
  // com a inclusão so store, toda a parte lógica e onde é armazenado foi mudado para
  // dentro do store

  // int _counter = 0;
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have pushed the button this many times:'),
            //Text('$_counter', style: Theme.of(context).textTheme.headline4),
            // pelo appStore utilizar o Store que extende de ChangeNotifier,
            // pode conectar diretamente pelo animation, já que ele é um listener
            AnimatedBuilder(
              animation: appStore,
              builder: (_, __) {
                return Text(
                  appStore.state.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // aqui ativa o tipo de ação que deve ser enviado para o store através desse dispatcher
        onPressed: () => appStore.dispatcher(AppAction.increment),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {