import 'dart:ui';

//import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:flutter/material.dart';

class Draw3 extends StatefulWidget {
  const Draw3({Key? key}) : super(key: key);

  @override
  _Draw3State createState() => _Draw3State();
}

class _Draw3State extends State<Draw3> {
  List<TouchPoints?> points = [];

  Color selectedColor = Colors.black;
  double opacity = 1.0;
  StrokeCap strokeType = StrokeCap.round;
  double strokeWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanStart: (details) => setState(() {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          points.add(TouchPoints(
            points: renderBox.globalToLocal(details.globalPosition),
            paint: Paint()
              ..isAntiAlias = true
              ..color = selectedColor.withOpacity(opacity)
              ..strokeCap = strokeType
              ..strokeWidth = strokeWidth,
          ));
        }),
        onPanUpdate: (details) => setState(() {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          points.add(TouchPoints(
            points: renderBox.globalToLocal(details.globalPosition),
            paint: Paint()
              ..isAntiAlias = true
              ..color = selectedColor.withOpacity(opacity)
              ..strokeCap = strokeType
              ..strokeWidth = strokeWidth,
          ));
        }),
        onPanEnd: (details) => setState(() {
          points.add(null);
        }),
        child: Stack(
          children: [
            Center(
              child: Image.asset("assets/img/animals/spider.png"),
            ),
            CustomPaint(
              size: Size.infinite,
              painter: MyPainter(pointsList: points),
            ),
          ],
        ),
      ),
      // floatingActionButton: AnimatedFloatingActionButton(
      //   fabButtons: fabOption(),
      //   colorStartAnimation: Colors.blue,
      //   colorEndAnimation: Colors.cyan,
      //   animatedIconData: AnimatedIcons.menu_close,
      // ),
    );
  }

  List<Widget> fabOption() {
    return [
      FloatingActionButton(
        heroTag: "paint_stroke",
        child: Icon(Icons.brush),
        tooltip: 'Stroke',
        //min: 0, max: 50
        onPressed: () => setState(() {
          _pickStroke();
        }),
      ),
      FloatingActionButton(
        heroTag: "paint_opacity",
        child: Icon(Icons.opacity),
        tooltip: 'Opacity',
        //min:0, max:1
        onPressed: () => setState(() {
          _opacity();
        }),
      ),

      //FAB for resetting screen
      FloatingActionButton(
        heroTag: "erase",
        child: Icon(Icons.clear),
        tooltip: "Erase",
        onPressed: () => setState(() {
          points.clear();
        }),
      ),
      FloatingActionButton(
        backgroundColor: Colors.white,
        heroTag: "color_red",
        child: colorMenuItem(Colors.red),
        tooltip: 'Color',
        onPressed: () => setState(() {
          selectedColor = Colors.red;
        }),
      ),
      FloatingActionButton(
        backgroundColor: Colors.white,
        heroTag: "color_green",
        child: colorMenuItem(Colors.green),
        tooltip: 'Color',
        onPressed: () => setState(() {
          selectedColor = Colors.green;
        }),
      ),
      FloatingActionButton(
        backgroundColor: Colors.white,
        heroTag: "color_pink",
        child: colorMenuItem(Colors.pink),
        tooltip: 'Color',
        onPressed: () => setState(() {
          selectedColor = Colors.pink;
        }),
      ),
      FloatingActionButton(
        backgroundColor: Colors.white,
        heroTag: "color_blue",
        child: colorMenuItem(Colors.blue),
        tooltip: 'Color',
        onPressed: () => setState(() {
          selectedColor = Colors.blue;
        }),
      ),
    ];
  }

  Future<void> _opacity() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClipOval(
          child: AlertDialog(
            actions: [
              IconButton(
                icon: Icon(Icons.opacity, size: 24),
                onPressed: () {
                  opacity = 0.1;
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                icon: Icon(Icons.opacity, size: 40),
                onPressed: () {
                  opacity = 0.5;
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                icon: Icon(Icons.opacity, size: 60),
                onPressed: () {
                  opacity = 1.0;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickStroke() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return ClipOval(
          child: AlertDialog(
            actions: [
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  strokeWidth = 3.0;
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                icon: Icon(Icons.brush, size: 24),
                onPressed: () {
                  strokeWidth = 10.0;
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                icon: Icon(Icons.brush, size: 40),
                onPressed: () {
                  strokeWidth = 30.0;
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                icon: Icon(Icons.brush, size: 60),
                onPressed: () {
                  strokeWidth = 50.0;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget colorMenuItem(Color color) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedColor = color;
      }),
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 8.0),
          height: 36,
          width: 36,
          color: color,
        ),
      ),
    );
  }
}

class TouchPoints {
  TouchPoints({
    required this.paint,
    required this.points,
  });

  Paint paint;
  Offset points;
}

class MyPainter extends CustomPainter {
  MyPainter({required this.pointsList});

  List<TouchPoints?> pointsList;
  List<Offset> offsetPoints = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        // se o ponto atual e o ponto seguinte estão disponíveis
        // desenha a linha
        canvas.drawLine(
          pointsList[i]!.points,
          pointsList[i + 1]!.points,
          pointsList[i]!.paint,
        );
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        // se apenas o ponto atual está disponível

        offsetPoints.clear();
        offsetPoints.add(pointsList[i]!.points);
        offsetPoints.add(Offset(
          pointsList[i]!.points.dx + 0.1,
          pointsList[i]!.points.dy + 0.1,
        ));

        //Draw points when two points are not next to each other
        canvas.drawPoints(
          PointMode.points,
          offsetPoints,
          pointsList[i]!.paint,
        );
      }
    }
  }

  // retorna true para pintar novamente a cada alteração feita
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
