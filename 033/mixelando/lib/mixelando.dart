import 'package:mixelando/birds/dove.dart';
import 'package:mixelando/mammals/cat.dart';

// https://medium.com/flutter-community/dart-what-are-mixins-3a72344011f3
// https://www.digitalocean.com/community/tutorials/dart-mixins

void main(List<String> arguments) {
  Dove dove = Dove('cagão');
  dove.fly();
  dove.walk();

  Cat cat = Cat('miau');
  cat.walk();
}
