import 'package:android_and_ios_calculate_imc/bloc/imc_bloc.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = new ImcBloc();
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
                controller: bloc.heightController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: CupertinoTextField(
                placeholder: "Peso (kg)",
                keyboardType: TextInputType.number,
                controller: bloc.weightController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                bloc.result,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: CupertinoButton.filled(
                onPressed: () => setState(() {
                  bloc.calculate();
                }),
                child: Text("Calcular"),
              ),
            )
          ],
        ));
  }
}
