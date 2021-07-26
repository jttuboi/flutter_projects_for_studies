import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Hero4Page extends StatelessWidget {
  static double kMinRadius = 32.0;
  static double kMaxRadius = 128.0;
  static Interval opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static RectTween _createRectTween(Rect? begin, Rect? end) {
    // faz a animação ser redonda por partir pelo centro
    return MaterialRectCenterArcTween(begin: begin, end: end);
    // esse altera a animação para forma oval (nao sei qual parametro está utilizando para calcular)
    //return MaterialRectArcTween(begin: begin, end: end);
  }

  // pagina que contem o nome e o retangulo em volta da imagem com zoom
  static Widget _buildPage(context, String imageUrl, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: kMaxRadius * 2.0,
                height: kMaxRadius * 2.0,
                child: Hero(
                  createRectTween: _createRectTween,
                  tag: imageUrl,
                  child: RadialExpansion(
                    maxRadius: kMaxRadius,
                    // widget onde contem a imagem e os dados para o tap pra troca de eventos
                    child: Photo(
                      imageUrl: imageUrl,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ),
              Text(
                description,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textScaleFactor: 3.0,
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(context, String imageUrl, String description) {
    return SizedBox(
      width: kMinRadius * 2.0,
      height: kMinRadius * 2.0,
      child: Hero(
        createRectTween: _createRectTween,
        tag: imageUrl,
        child: RadialExpansion(
          maxRadius: kMaxRadius,
          // widget onde contem a imagem e os dados para o tap pra troca de eventos
          child: Photo(
            imageUrl: imageUrl,
            onTap: () => Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  // gera os valores para fazezr a animacao de abrir e fechar
                  // o circulo
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: opacityCurve.transform(animation.value),
                        // constroi a pagina do item, nesse caso não é um scaffold
                        // é um retangulo simples com o nome do animal
                        child: _buildPage(context, imageUrl, description),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    timeDilation = 5.0; // 1.0 is normal animation speed.

    return Scaffold(
      appBar: AppBar(title: const Text('Radial Transition Demo')),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        // utiliza as coordenadas top-left para orientar os retangulos
        // o Alignment utiliza o centro do retangulo
        // obs: no final os 2 sao iguais dependendo de qual widget está sendo usado
        // imagino que fará diferença se usar positioned ou stack, por exemplo
        alignment: FractionalOffset.bottomLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHero(context, "assets/img/animals/mule.png", 'mule'),
            _buildHero(context, "assets/img/animals/spider.png", 'spider'),
            _buildHero(context, "assets/img/animals/dove.png", 'dove'),
          ],
        ),
      ),
    );
  }
}

class Photo extends StatelessWidget {
  const Photo({Key? key, required this.imageUrl, this.onTap}) : super(key: key);

  final String imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(context) {
    return Material(
      // Slightly opaque color appears where the image has transparency.
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, size) {
            return Image.asset(imageUrl, fit: BoxFit.contain);
          },
        ),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  const RadialExpansion({Key? key, required this.maxRadius, this.child})
      // calcula o clip rect size logo no inicio do
      : clipRectSize = 2.0 * (maxRadius / math.sqrt2),
        super(key: key);

  final double maxRadius;
  final double clipRectSize;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectSize,
          height: clipRectSize,
          child: ClipRect(child: child),
        ),
      ),
    );
  }
}
