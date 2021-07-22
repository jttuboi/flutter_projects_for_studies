import 'package:alcool_or_gasoline/assets/widgets/loading_button.widget.dart';
import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success(
    this.result, {
    Key? key,
    required this.reset,
  }) : super(key: key);

  final String result;
  final VoidCallback reset;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: [
          SizedBox(height: 50),
          Text(
            result,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 40.0,
              fontFamily: 'Big Shoulders Display',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          LoadingButton(
            "CALCULAR NOVAMENTE",
            busy: false,
            invert: true,
            onPressed: reset,
          )
        ],
      ),
    );
  }
}
