import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

// a animação parece o flutter decidir
// deve ter um controle para animação
class Hero2Page extends StatelessWidget {
  @override
  Widget build(context) {
    // > 1.0 -> a velocidade da animação diminui
    // 1.0 -> velocidade normal da animação
    // ALTERA ANIMAçÃO DE TODAS AS TELAS, TOMAR CUIDADO
    timeDilation = 1.0;

    return Scaffold(
      appBar: AppBar(title: const Text("Pagina principal")),
      body: Center(
        child: PhotoHero(
          imgUrl: "assets/img/neptune.png",
          width: 300.0, // tamanho atual
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Hero2ItemPage()),
          ),
        ),
      ),
    );
  }
}

class Hero2ItemPage extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pagina do item")),
      body: Container(
        color: Colors.lightBlueAccent,
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.topRight,
        child: Column(
          children: [
            PhotoHero(
              imgUrl: "assets/img/neptune.png",
              width: 100.0, // tamanho final
              onTap: () => Navigator.of(context).pop(),
            ),
            Text("aqui é um texto que deve ficar abaixo da imagem"),
          ],
        ),
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({
    Key? key,
    required this.imgUrl,
    required this.width,
    this.onTap,
  }) : super(key: key);

  final String imgUrl;
  final double width;
  final VoidCallback? onTap;

  @override
  Widget build(context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: imgUrl, // é necessário para linkar o pai com filho
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // região onde pode clicar
            onTap: onTap,
            child: Image.asset(imgUrl, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
