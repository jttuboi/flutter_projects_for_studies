import 'package:mobx/mobx.dart';

class AppStoreMobx {
  final counter = Observable<int>(0);
  late final increment = Action(_increment);

  void _increment() {
    counter.value++;
  }
}

final appStoreMobx = AppStoreMobx();
