import 'connection.dart';

class Rethinkdb {
  Rethinkdb();

  Future<Connection> connect({String? host, int? port}) async {
    return Connection();
  }

  Rethinkdb table(String _) {
    return this;
  }

  Rethinkdb expr(List<String> _) {
    return this;
  }

  Rethinkdb contains(dynamic _) {
    return this;
  }

  Rethinkdb insert(Map _, [Map? __]) {
    return this;
  }

  Rethinkdb filter(dynamic _) {
    return this;
  }

  Rethinkdb changes(Map _) {
    return this;
  }

  Rethinkdb update(Map _) {
    return this;
  }

  Rethinkdb delete([Map? _]) {
    return this;
  }

  Rethinkdb get(dynamic _) {
    return this;
  }

  Rethinkdb dbCreate(dynamic _) {
    return this;
  }

  Rethinkdb tableCreate(dynamic _) {
    return this;
  }

  dynamic run(Connection _) {
    return this;
  }
}
