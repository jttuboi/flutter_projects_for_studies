import 'package:person_form/models/models/person.dart';

abstract class IPersonFormRepository {
  Future<void> save(Person person);

  Future<void> delete(Person person);
}
