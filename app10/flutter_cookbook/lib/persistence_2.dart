import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Persistence2 extends StatefulWidget {
  final CounterStorage storage = CounterStorage();

  @override
  _Persistence2State createState() => _Persistence2State();
}

class _Persistence2State extends State<Persistence2> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
    });

    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("usando files"),
      ),
      body: Center(
        child: Text(
          'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CounterStorage {
  // diretório temporário
  // um diretório (cache) que o OS pode limpar a qualquer momento.
  // iOS -> NSCachesDirectory
  // android -> getCacheDir()

  // diretório de documentos
  // um diretório para o app armazenar arquivos que apenas ele tem acesso.
  // o diretório só é limpo pelo OS no momento em que o app é deletado
  // iOS -> NSDocumentDirectory
  // android -> AppData directory

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      return 0; // If encountering an error, return 0
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    // nesse exemplo a escrita no arquivo é 1 pra 1, ou seja,
    // não há outros dados no arquivo, sendo mais fácil a recuperação
    // do conteúdo pelo readAsString()
    return file.writeAsString('$counter');
  }
}

// To test code that interacts with files, you need to mock calls to the
// MethodChannel—the class that communicates with the host platform.
// For security reasons, you can’t directly interact with the file system
// on a device, so you interact with the test environment’s file system.
// To mock the method call, provide a setupAll() function in the test file.
// This function runs before the tests are executed.

// setUpAll(() async {
//   // Create a temporary directory.
//   final directory = await Directory.systemTemp.createTemp();
//   // Mock out the MethodChannel for the path_provider plugin.
//   const MethodChannel('plugins.flutter.io/path_provider')
//       .setMockMethodCallHandler((MethodCall methodCall) async {
//     // If you're getting the apps documents directory, return the path to the
//     // temp directory on the test environment instead.
//     if (methodCall.method == 'getApplicationDocumentsDirectory') {
//       return directory.path;
//     }
//     return null;
//   });
// });
