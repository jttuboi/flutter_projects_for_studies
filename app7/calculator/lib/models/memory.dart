class Memory {
  static const operations = const ["%", "/", "x", "-", "+", "="];

  String _value = "0";
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String _operation = "";
  bool _wipeValue = false;

  String get value {
    return _value;
  }

  void applyCommand(String command) {
    if (command == "AC") {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }
  }

  _allClear() {
    _value = "0";
  }

  _setOperation(String newOperation) {
    _wipeValue = true;
  }

  _addDigit(String digit) {
    final isDot = digit == ".";
    final wipeValue = (_value == "0" && !isDot) || _wipeValue;

    if (isDot && _value.contains(".") && !wipeValue) {
      return;
    }

    final emptyValue = isDot ? "0" : "";
    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + digit;
    _wipeValue = false;

    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
  }
}
