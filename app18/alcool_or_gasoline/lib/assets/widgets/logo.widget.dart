import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60.0),
        Image.asset(
          'lib/assets/images/aog-white.png',
          height: 80.0,
        ),
        SizedBox(height: 10.0),
        Text(
          'Alcool ou Gasolina',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontFamily: "Big Shoulders Display",
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.0),
      ],
    );
  }
}
