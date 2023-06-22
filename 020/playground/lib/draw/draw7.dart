import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Draw7 extends StatelessWidget {
  const Draw7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AllPathsState(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrentPathState(),
        ),
      ],
      child: Scaffold(
        body: Consumer<AllPathsState>(
          builder: (context, value, child) {
            return Stack(
              fit: StackFit.expand,
              children: [
                // aqui é armazenado a imagem final
                // quando desenha uma linha, aquela linha é desenhada usando outro provider,
                // assim não precisando redesenhar todos os pontos já desenhados.
                // então quando tira o dedo da tela, ou seja, termina de desenhar a linha,
                // os dados são passados para esse, cujo desenha todos os pontos apenas 1 vez.
                RepaintBoundary(
                  child: CustomPaint(
                    isComplex: true,
                    painter: DrawAllPointsPainter(value.points),
                    child: Container(),
                  ),
                ),
                if (child != null) child,
              ],
            );
          },
          child: const CurrentPathPaint(),
        ),
      ),
    );
  }
}

class CurrentPathPaint extends StatelessWidget {
  const CurrentPathPaint();

  @override
  Widget build(BuildContext context) {
    CurrentPathState currentPointsState =
        Provider.of<CurrentPathState>(context, listen: false);
    AllPathsState mainPointsState =
        Provider.of<AllPathsState>(context, listen: false);
    return Consumer<CurrentPathState>(
      builder: (_, model, child) => Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(
            child: CustomPaint(
              isComplex: true,
              painter: DrawCurrentPointsPainter(model.points),
              child: Container(),
            ),
          ),
          if (child != null) child,
        ],
      ),
      child: GestureDetector(
          // aqui cria os pontos que é guardado no CurrentPathState
          onPanStart: (details) =>
              currentPointsState.addPoint(details.localPosition),
          // o mesmo acontece aqui, é guardado no CurrentPathState
          onPanUpdate: (details) =>
              currentPointsState.addPoint(details.localPosition),
          // após finalizar, os são adicionados no AllPathsState
          // e o CurrentPathState é resetado
          onPanEnd: (details) {
            // esse é o único momento que é desenhado todos pontos já desenhados,
            // assim evitando desenhar esses pontos toda vez que estiver desenhando uma linha.
            mainPointsState.addPath(currentPointsState.points);
            currentPointsState.resetPoints();
            // ao evitar desenhar todos os pontos, isso ajuda na performance, não sobrecarregando o repaint
          }),
    );
  }
}

class DrawAllPointsPainter extends CustomPainter {
  DrawAllPointsPainter(this.points);

  List<List<Offset>> points;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 8.0
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final pointsSet in points) {
      canvas.drawPoints(PointMode.polygon, pointsSet, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DrawCurrentPointsPainter extends CustomPainter {
  DrawCurrentPointsPainter(this.points);

  List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class AllPathsState extends ChangeNotifier {
  AllPathsState() {
    points = [];
  }

  late List<List<Offset>> points;

  void addPath(List<Offset> path) {
    points.add(path);
    notifyListeners();
  }
}

class CurrentPathState with ChangeNotifier {
  CurrentPathState() {
    points = [];
  }

  late List<Offset> points;

  addPoint(Offset point) {
    points.add(point);
    notifyListeners();
  }

  resetPoints() {
    points = [];
    notifyListeners();
  }
}
