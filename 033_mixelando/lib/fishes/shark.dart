import 'package:mixelando/fishes/fish.dart';
import 'package:mixelando/movements/swimmer.dart';

class Shark extends Fish with Swimmer {
  Shark(String name) : super(name);
}
