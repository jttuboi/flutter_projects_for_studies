import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Persistence1 extends StatelessWidget {
  Persistence1({Key? key}) : super(key: key);

  // OBS: TODOS METODOS RELACIONADOS AO BANCO DE DADOS NÃO DEVE FICAR NA AREA
  //      DA VIEW, POIS ELA PERTENCE A MODEL.
  //      NESSE EXEMPLO ESTÁ SENDO FEITO DENTRO DO WIDGET APENAS PARA APRENDIZAGEM
  //      DA UTILIZAÇÃO DO BANCO DE DADOS PELO FLUTTER

  // https://www.sqlitetutorial.net/

  testando() async {
    // evita erros causado pelo "flutter upgrade"
    WidgetsFlutterBinding.ensureInitialized();

    // abre conexão com a base e armazena a referencia
    final database = openDatabase(
      // path do database.
      // o uso do join é a forma recomendada para ter certeza que a base é criada
      // no caminho certo de cada plataforma
      join(await getDatabasesPath(), "doggie_database.db"),

      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },

      // versão do database. serve para controle do versionamento do database.
      version: 1,
    );

    insertDog(Dog dog) async {
      // recupera uma referencia do database a partir do momento que ela estiver pronta pra uso
      final db = await database;

      await db.insert(
        "dogs",
        dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<List<Dog>> dogs() async {
      final db = await database;

      final List<Map<String, dynamic>> maps = await db.query('dogs');

      return List.generate(maps.length, (i) {
        return Dog(
          id: maps[i]['id'],
          name: maps[i]['name'],
          age: maps[i]['age'],
        );
      });
    }

    // primeiro teste executado para inserção
    var fido = Dog(id: 0, name: "Fido", age: 35);
    await insertDog(fido);
    print("inserido: ${await dogs()}");

    Future<void> updateDog(Dog dog) async {
      final db = await database;

      await db.update(
        'dogs',
        dog.toMap(),
        where: 'id = ?',
        whereArgs: [dog.id], // isso previne SQL injection
      );
    }

    fido = Dog(
      id: fido.id,
      name: fido.name,
      age: fido.age + 7,
    );
    await updateDog(fido);
    print("atualizado(age deve ser 42): ${await dogs()}");

    Future<void> deleteDog(int id) async {
      final db = await database;

      await db.delete(
        'dogs',
        where: 'id = ?',
        whereArgs: [id], // isso previne SQL injection
      );
    }

    await deleteDog(fido.id);
    print("deletado(deve aparecer vazio): ${await dogs()}");

    print("se terminou de visualizar o debug console, pode clicar no voltar");
  }

  @override
  Widget build(BuildContext context) {
    testando();

    return Scaffold(
      appBar: AppBar(
        title: Text("usando sqlite"),
      ),
      body: Center(
        child: Text("olhar no debug console"),
      ),
    );
  }
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({required this.id, required this.name, required this.age});

  // converte para um Map. os keys devem ter os mesmos nomes das colunas da tabela.
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "age": age};
  }

  // apenas para melhor visualização dos dados via print
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
