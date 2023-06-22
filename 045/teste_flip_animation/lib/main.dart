import 'dart:math';

import 'package:flutter/material.dart';

// https://medium.com/flutter-community/flutter-flip-card-animation-eb25c403f371

void main() {
  runApp(const MaterialApp(home: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _flipXAxis = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: RotatedBox(
              quarterTurns: _flipXAxis ? 0 : 1,
              child: const Icon(Icons.flip),
            ),
            onPressed: _changeRotationAxis,
          ),
        ],
      ),
      body: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
        child: Center(
          child: Container(
            constraints: BoxConstraints.tight(const Size.square(200.0)),
            child: const CFlipCard(
              frontWidget: CCard(key: ValueKey(true), backgroundColor: Colors.blue, faceName: "Front"),
              backWidget: CCard(key: ValueKey(false), backgroundColor: Colors.blueAccent, faceName: "Rear"),
            ),
          ),
        ),
      ),
    );
  }

  void _changeRotationAxis() {
    setState(() {
      _flipXAxis = !_flipXAxis;
    });
  }
}

class CCard extends StatelessWidget {
  const CCard({required this.faceName, required this.backgroundColor, super.key});

  final String faceName;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(20.0), color: backgroundColor),
      key: key,
      child: Center(
        child: Text(faceName.substring(0, 1), style: const TextStyle(fontSize: 80.0)),
      ),
    );
  }
}

class CFlipCard extends StatefulWidget {
  const CFlipCard({required this.frontWidget, required this.backWidget, super.key});

  final Widget frontWidget;
  final Widget backWidget;
  @override
  State<CFlipCard> createState() => _CFlipCardState();
}

class _CFlipCardState extends State<CFlipCard> {
  bool _showFrontSide = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: (child, animation) {
          // a animação utiliza valores de PI (3.14) até 0.
          final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);

          return AnimatedBuilder(
            animation: rotateAnim,
            child: child,
            builder: (_, child) {
              // nesse momento ele executa as 2 widgets ao msm tempo, se habilitar os logs, verá q ele executa tanto o [<true>] qnto o [<false>]
              // d.log(rotateAnim.value.toString());
              // d.log(child!.key.toString());

              // verifica se é o de trás q está buildando
              final isUnder = (ValueKey(_showFrontSide) != child!.key);

              // não entendi como é o calculo dessa tilt
              var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
              tilt *= isUnder ? -1.0 : 1.0;
              //d.log(tilt.toString());

              final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;

              return Transform(
                transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
                // dá pra fazer o flip verticalmente
                //transform: _flipXAxis ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt)) : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
                alignment: Alignment.center,
                child: child,
              );
            },
          );
        },
        layoutBuilder: (currentChild, previousChildren) {
          // é criado uma Stack para deixar o frontWidget e o backWidget mostrando ao msm tempo na camada correta.
          // pelo que entendi, usando frontWidget e backWidget como exemplo, inicialmente o currentChild do AnimatedChild
          // é o frontWidget (ver no AnimatedChild.child). então qndo ativa a ação para iniciar o flip,
          // o frontWidget torna parte do previousChildren e o backWidget torna o currentChild.
          // nesse momento, bem no início da animação, se não tiver essa Stack, ele apenas mostraria o currentChild,
          // nesse caso o backWidget. então metade da animação permaneceria com o backWidget a mostra, sendo q quem
          // deveria estar mostrando até o meio da animação é o frontWidget. Para arrumar isso foi utilizado o
          // Stack, q empilha primeiro o backWidget e depois o frontWidget, assim mostrando o front até o meio da
          // animação e mudando em seguida após o meio da animação par amostrar o backWidget.
          return Stack(children: [currentChild!, ...previousChildren]);
        },
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _showFrontSide ? widget.frontWidget : widget.backWidget,
      ),
    );
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }
}
