import 'package:mixelando/mammals/mammal.dart';
import 'package:mixelando/movements/flyer.dart';
import 'package:mixelando/movements/walker.dart';

class Bat extends Mammal with Walker, Flyer {
  Bat(String name) : super(name);
}
