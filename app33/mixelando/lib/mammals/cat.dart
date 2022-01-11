import 'package:mixelando/mammals/mammal.dart';
import 'package:mixelando/movements/walker.dart';

class Cat extends Mammal with Walker {
  Cat(String name) : super(name);
}
