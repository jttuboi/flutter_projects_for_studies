import 'package:mixelando/fishes/fish.dart';
import 'package:mixelando/movements/flyer.dart';
import 'package:mixelando/movements/swimmer.dart';

class FlyingFish extends Fish with Swimmer, Flyer {
  FlyingFish(String name) : super(name);
}
