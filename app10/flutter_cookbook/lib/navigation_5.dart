import 'package:flutter/material.dart';

class Navigation5 extends StatelessWidget {
  const Navigation5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("return value")),
      body: Center(child: SelectionButton()),
    );
  }
}

class SelectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _navigateAndDisplaySelection(context),
      child: Text('Pick an option, any option!'),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    // o result é o valor em que é esperado pela outra tela. Ele fica no aguardo até outra tela
    // ser usado o pop()
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PickupScreen()),
    );

    // outra forma de criar um snack bar
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}

class PickupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick an option')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                // o segundo parametro do pop() é o conteúdo que irá retornar
                onPressed: () => Navigator.pop(context, 'Yep!'),
                child: Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                // o segundo parametro do pop() é o conteúdo que irá retornar
                onPressed: () => Navigator.pop(context, 'Nope.'),
                child: Text('Nope.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
