import 'dart:math';

import 'package:flutter/material.dart';

class Draw5 extends StatefulWidget {
  const Draw5({Key? key}) : super(key: key);

  @override
  _Draw5State createState() => _Draw5State();
}

class _Draw5State extends State<Draw5> {
  final _paintKey = GlobalKey();
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    print("build Scaffold");
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackground(),
          _buildCursor(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    // quando algum paint precisa ser atualizado, o build() é construído novamente
    // porém o RepaintBoundary() está ligado com o CustomPaint() dentro dele.
    // o controle para repintar é controlado pelo CustomPainter::shouldRepaint()
    // O CustomPaint() contém parametros que ajuda no controle do cache.
    return RepaintBoundary(
      child: CustomPaint(
        painter: MyExpensiveBackground(MediaQuery.of(context).size),
        isComplex: true,
        willChange: false,
      ),
    );
  }

  Widget _buildCursor() {
    return Listener(
      onPointerDown: _updateOffset,
      onPointerMove: _updateOffset,
      child: CustomPaint(
        key: _paintKey,
        painter: MyPointer(_offset),
        child: ConstrainedBox(constraints: BoxConstraints.expand()),
      ),
    );
  }

  void _updateOffset(PointerEvent event) {
    // pega o plano cartesiano do CustomPaint (que contém o cursor)
    RenderBox? referenceBox =
        _paintKey.currentContext?.findRenderObject() as RenderBox;

    // converte a posição do app (posição global) para posição de dentro do Widget (posição local)
    Offset offset = referenceBox.globalToLocal(event.position);
    setState(() {
      _offset = offset;
    });
  }
}

class MyExpensiveBackground extends CustomPainter {
  MyExpensiveBackground(this._size);

  static const List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.purple,
    Colors.orange,
  ];

  Size _size;

  @override
  void paint(Canvas canvas, Size size) {
    print("MyExpensiveBackground precisa executar 1 vez");
    final rand = Random(12345);

    for (int i = 0; i < 10000; i++) {
      canvas.drawOval(
          Rect.fromCenter(
            center: Offset(
              rand.nextDouble() * _size.width - 100,
              rand.nextDouble() * _size.height,
            ),
            width: rand.nextDouble() * rand.nextInt(150) + 200,
            height: rand.nextDouble() * rand.nextInt(150) + 200,
          ),
          Paint()
            ..color = colors[rand.nextInt(colors.length)].withOpacity(0.3));
    }
  }

  @override
  bool shouldRepaint(MyExpensiveBackground other) => false;
}

class MyPointer extends CustomPainter {
  MyPointer(this._offset);

  final Offset _offset;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      _offset,
      10.0,
      Paint()..color = Colors.black,
    );
  }

  @override
  bool shouldRepaint(MyPointer old) {
    return old._offset != _offset;
  }
}
