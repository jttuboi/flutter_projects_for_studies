import 'dart:math';

final names = ['Maria', 'Jão', 'Pedro', 'Ana', 'Lucas', 'Luisa'];

class Person {
  Person() : name = names[Random().nextInt(names.length)];

  Person.empty() : name = '';

  String name;
}
