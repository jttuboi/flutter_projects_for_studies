class Memory {
  String _value = "0";

  String get value {
    return _value;
  }

  void applyCommand(String command) {
    _value += command;
  }
}
