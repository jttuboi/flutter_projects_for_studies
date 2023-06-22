import 'package:mixelando/birds/bird.dart';
import 'package:mixelando/movements/flyer.dart';
import 'package:mixelando/movements/swimmer.dart';
import 'package:mixelando/movements/walker.dart';

class Duck extends Bird with Walker, Swimmer, Flyer {
  Duck(String name) : super(name);
}
