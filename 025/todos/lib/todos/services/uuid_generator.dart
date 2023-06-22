import 'package:todos/todos/services/services.dart';
import 'package:uuid/uuid.dart';

class UuidGenerator implements IUuidGenerator {
  @override
  String getV4() {
    return const Uuid().v4();
  }
}
