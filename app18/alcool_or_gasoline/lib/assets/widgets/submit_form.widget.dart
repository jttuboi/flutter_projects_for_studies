import 'package:alcool_or_gasoline/assets/widgets/input.widget.dart';
import 'package:alcool_or_gasoline/assets/widgets/loading_button.widget.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

class SubmitForm extends StatelessWidget {
  SubmitForm({
    Key? key,
    required this.busy,
    required this.submit,
    required this.alcoholControllerMask,
    required this.gasolineControllerMask,
  }) : super(key: key);

  final bool busy;
  final VoidCallback submit;
  final MoneyMaskedTextController alcoholControllerMask;
  final MoneyMaskedTextController gasolineControllerMask;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child:
              Input(label: "Gasolina", controllerMask: gasolineControllerMask),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Input(label: "Álcool", controllerMask: alcoholControllerMask),
        ),
        SizedBox(height: 30),
        LoadingButton(
          "CALCULAR",
          busy: busy,
          invert: false,
          onPressed: submit,
        ),
      ],
    );
  }
}
