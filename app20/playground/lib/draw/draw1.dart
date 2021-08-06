import 'package:flutter/material.dart';

class Draw1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFFf9a45f), Color(0xFFf86a5c)]),
    );
    var container = Container(
      // MediaQuery dá o tamanho da tela
      width: MediaQuery.of(context).size.width, // mW
      height: MediaQuery.of(context).size.height / 2.7, // mH
      decoration: boxDecoration,
    );
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(clipper: ClipLineTo(), child: container),
            ClipPath(clipper: ClipQuadraticBezierTo(), child: container),
            ClipPath(
                clipper: ClipQuadraticBezierToWithTwoControlPoints(),
                child: container),
          ],
        ),
      ),
    );
  }
}

class ClipLineTo extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // tem o Container que tem um gradient com tamanho (mW, mH)
    // constrói uma linha até (0, mH)
    // depois constrói uma linha até (mW, 0)
    // criando assim um triangulo a partir do (0,0) do Container

    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}

class ClipQuadraticBezierTo extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // tem o Container que tem um gradient com tamanho (mW, mH)
    // constrói uma linha até (0, mH)
    // depois constrói uma linha curva até (mW, 0)
    // criando assim um triangulo onde a segunda linha é curvada
    Path path = Path();
    path.lineTo(0.0, size.height);

    // cria o ponto que orienta a curvatura dada pelo bezier
    Offset controlPoint = Offset(
      ((size.width / 2) / 2),
      ((size.height / 2) / 2),
    );
    // ponto que encerra a curvatura
    Offset endPoint = Offset(
      size.width,
      0,
    );

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}

class ClipQuadraticBezierToWithTwoControlPoints extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // tem o Container que tem um gradient com tamanho (mW, mH)
    // constrói uma linha até (0, mH)
    // depois constrói uma linha curva até (mW, 0)
    // criando assim um triangulo onde a segunda linha é curvada
    Path path = Path();
    path.lineTo(0.0, size.height);

    // cria os pontos para primeira curvatura
    Offset firstControlPoint = Offset(
      size.width / 4,
      size.height / 2,
    );
    Offset firstEndPoint = Offset(
      size.width / 2,
      size.height / 2,
    );
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    // cria os pontos para próxima curvatura
    Offset secondControlPoint = Offset(
      size.width,
      size.height / 2,
    );
    Offset secondEndPoint = Offset(
      size.width,
      0,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
