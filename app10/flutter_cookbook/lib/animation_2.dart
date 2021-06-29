import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class Animation2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DraggableCard(
        child: FlutterLogo(size: 64),
      ),
    );
  }
}

// essa classe simula o drag de um card para qualquer parte da tela e ao drop
// o card volta para o centro da tela
class DraggableCard extends StatefulWidget {
  final Widget child;

  DraggableCard({required this.child});

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _animation;

  /// The alignment of the card as it is dragged or being animated.
  ///
  /// While the card is being dragged, this value is set to the values computed
  /// in the GestureDetector onPanUpdate callback. If the animation is running,
  /// this value is set to the value of the [_animation].
  Alignment _dragAlignment = Alignment.center;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // toda vez que a animação é modificada, chama o conteúdo desse listener
    _controller.addListener(() {
      setState(() {
        // dá o valor da animação para a posição do card
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // https://community.appway.com/screen/kb/article/screen-components-what-s-a-pixel-1482810924135
    // tamanho da tela em pixels lógicos (são pixels do software, não os pixels físicos)
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      // é ativado quando há o toque na tela (quando encosta o dedo)
      onPanDown: (details) {
        // o controlador é parado, nesse caso a animação de voltar não é processada
        _controller.stop();
      },

      // é ativado no arrasto do toque da tela (quando move o dedo)
      onPanUpdate: (details) {
        // a posição do alinhamento é atualizada
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },

      // é ativado para de tocar na tela (quando tira o dedo)
      onPanEnd: (details) {
        // os details do onPanDown, onPanUpdate e onPanEnd são dados relacionados ao toque,
        // como exemplo, posição em que esta sendo tocado, velocidade em que está se movendo
        // e posição em que tira o dedo da tela
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },

      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }

  // https://flutter.dev/docs/cookbook/animation/physics-simulation#step-4-calculate-the-velocity-to-simulate-a-springing-motion
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    // aqui é criada a animação passando o tween, que nesse caso está sendo utilizado o tween de alignment.
    // o inicio é a posição, nesse caso direção, onde está o objeto em relação ao centro [0, 0].
    // o fim é a posição central onde deve terminar a animação
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    // a unitVelocity é a velocidade atual do arrasto no momento que é soltado o dedo.
    // é uma velocidade relativa para o intervalo da unit que varia entre valores [0.0 .. 1.0]
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const springDescription = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    // cria uma simulação do tipo spring (imagino que seja algum efeito de mola, carece mais estudos sobre isso)
    // para simular, precisa apenas dos dados do corpo, o inicio e fim (0 e 1 nesse caso) e
    // a velocidade em que deve agira a simulação
    final simulation = SpringSimulation(springDescription, 0, 1, -unitVelocity);

    // inicia a animação com base no inicio/fim descrita no drive() e
    // o simulation controla o comportamento de como ele deve ser animado.
    // se não tivesse a simulation, ele seria uma animação linear descrita pelo drive()
    _controller.animateWith(simulation);
  }
}
