import 'package:flutter/material.dart';

class Draw2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ClipPath(
        clipper: CurveClipper(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: Image.asset(
            "assets/img/animals/spider.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    // linha esquerda
    path.lineTo(0.0, size.height - 20);

    // linha de baixo parte 1
    final firstControlPoint = Offset(
      size.width / 4,
      size.height,
    );
    final firstEndPoint = Offset(
      size.width / 2.25,
      size.height - 30.0,
    );
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    // linha de baixo parte 2
    var secondControlPoint = Offset(
      size.width - (size.width / 3.25),
      size.height - 65,
    );
    var secondEndPoint = Offset(
      size.width,
      size.height - 40,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    // linha direita
    path.lineTo(size.width, size.height - 40);

    // linha superior
    path.lineTo(size.width, 0.0);

    // termina o clip
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
