import 'package:mixelando/birds/dove.dart';
import 'package:mixelando/mammals/cat.dart';

void main(List<String> arguments) {
  Dove dove = Dove('cagão');
  dove.fly();
  dove.walk();

  Cat cat = Cat('miau');
  cat.walk();
}
