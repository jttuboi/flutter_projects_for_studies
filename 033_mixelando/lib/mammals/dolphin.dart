import 'package:mixelando/mammals/mammal.dart';
import 'package:mixelando/movements/swimmer.dart';

class Dolphin extends Mammal with Swimmer {
  Dolphin(String name) : super(name);
}
