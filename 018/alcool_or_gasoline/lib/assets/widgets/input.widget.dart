import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({Key? key, required this.label, required this.controllerMask})
      : super(key: key);

  final String label;
  final MoneyMaskedTextController controllerMask;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          alignment: Alignment.centerRight,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontFamily: "Big Shoulders Display",
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: controllerMask,
            style: TextStyle(
              color: Colors.white,
              fontSize: 45.0,
              fontFamily: "Big Shoulders Display",
            ),
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }
}
