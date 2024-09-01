import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Display extends StatelessWidget {
  final String text;

  Display(this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // ocupa todo espaço disponível na tela
      flex: 1,
      child: Container(
        color: Color(0xff303030),
        child: Column(
          // encosta os filhos no bottom
          mainAxisAlignment: MainAxisAlignment.end,
          // ocupa todo espaço relacionado a horizontal
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              // dá espaçamento interno do pai com o filho com uma distancia de 8.0
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                text,
                minFontSize: 20,
                maxFontSize: 80,
                maxLines: 1,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  decoration: TextDecoration.none,
                  fontSize: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
