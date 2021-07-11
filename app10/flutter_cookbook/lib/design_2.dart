import 'package:flutter/material.dart';

class Design2 extends StatefulWidget {
  @override
  _Design2State createState() => _Design2State();
}

class _Design2State extends State<Design2> {
  final List<String> _messages = [
    "test message 1.",
    "test message 2.",
    "are you still clicking?",
    "stop man!!",
    "error... restarting.",
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("snack bar"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final snackBar = SnackBar(
              content: Text(_messages[_currentIndex]),
              action: SnackBarAction(
                label: "undo",
                onPressed: () {
                  setState(() {
                    _currentIndex--;
                    if (_currentIndex < 0) {
                      _currentIndex = 0;
                    }
                  });
                },
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            setState(() {
              _currentIndex++;
              if (_currentIndex >= _messages.length) {
                _currentIndex = 0;
              }
            });
          },
          child: Text("show snackbar"),
        ),
      ),
    );
  }
}
