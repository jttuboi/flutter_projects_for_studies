import 'package:alcool_or_gasoline/assets/widgets/logo.widget.dart';
import 'package:alcool_or_gasoline/assets/widgets/submit_form.widget.dart';
import 'package:alcool_or_gasoline/assets/widgets/success.widget.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MoneyMaskedTextController _gasolineController =
      MoneyMaskedTextController(initialValue: 0);
  final MoneyMaskedTextController _alcoholController =
      MoneyMaskedTextController(initialValue: 0);

  bool _busy = false;
  bool _completed = false;
  String _resultMessage = "asdasdasd";
  Color _color = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnimatedContainer(
        duration: Duration(milliseconds: 1200),
        color: _color,
        child: ListView(
          children: [
            const Logo(),
            _completed
                ? Success(
                    _resultMessage,
                    reset: reset,
                  )
                : SubmitForm(
                    alcoholControllerMask: _alcoholController,
                    gasolineControllerMask: _gasolineController,
                    busy: _busy,
                    submit: calculate,
                  ),
          ],
        ),
      ),
    );
  }

  Future calculate() {
    String alcoholText =
        _alcoholController.text.replaceAll(RegExp(r'[,.]'), '');
    String gasolineText =
        _gasolineController.text.replaceAll(RegExp(r'[,.]'), '');

    double alcoholValue = double.parse(alcoholText) / 100;
    double gasolineValue = double.parse(gasolineText) / 100;
    double result = alcoholValue / gasolineValue;

    setState(() {
      _color = Colors.deepPurpleAccent;
      _completed = false;
      _busy = true;
    });

    return Future.delayed(Duration(seconds: 1), () {
      setState(() {
        // 70%
        if (result >= 0.7) {
          _resultMessage = "Compensa utilizar Gasolina!";
        } else {
          _resultMessage = "Compensa utilizar Álcool!";
        }

        _completed = true;
        _busy = false;
      });
    });
  }

  void reset() {
    setState(() {
      _color = Colors.deepPurple;
      _gasolineController.updateValue(0.0);
      _alcoholController.updateValue(0.0);
      _completed = false;
      _busy = false;
    });
  }
}
