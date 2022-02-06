import 'dart:async';

import 'package:manguinho/presentation/presentation.dart';

class StreamLoginPresenter {
  StreamLoginPresenter({required this.validation});

  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();
  var _state = LoginState();

  Stream<String?> get emailErrorStream => _controller.stream.map((state) => state.emailError);

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}

class LoginState {
  String? emailError;
}
