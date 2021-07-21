import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("IMC"),
        ),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: CupertinoTextField(
                placeholder: "Altura (cm)",
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: CupertinoTextField(
                placeholder: "Peso (kg)",
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "você esta fora de forma",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: CupertinoButton.filled(
                onPressed: () {},
                child: Text("Calcular"),
              ),
            )
          ],
        ));
  }
}
