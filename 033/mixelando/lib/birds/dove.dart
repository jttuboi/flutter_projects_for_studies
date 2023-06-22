import 'package:mixelando/movements/flyer.dart';
import 'package:mixelando/movements/walker.dart';

import 'bird.dart';

class Dove extends Bird with Walker, Flyer {
  Dove(String name) : super(name);
}
