import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

// ANALISADO SUPERFICIALMENTE, APENAS VI QUE A ANIMA"cAO ESTÄ MAIS SUAVE
// EM RELACAO AS BORDAS FORMADAS DURANTE A ANIMACAO
// Extends radial_hero_animaton by also animating the size of the rectangular clip.
// This more advanced example, provided for your reference, isn’t described in this guide.
class Hero6Page extends StatelessWidget {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const opacityCurve = Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  Widget _buildPage(context, String imageUrl, String description) {
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
                    minRadius: kMinRadius,
                    maxRadius: kMaxRadius,
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
          minRadius: kMinRadius,
          maxRadius: kMaxRadius,
          child: Photo(
            imageUrl: imageUrl,
            onTap: () => Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: opacityCurve.transform(animation.value),
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
  Widget build(BuildContext context) {
    timeDilation = 5.0; // 1.0 is normal animation speed.

    return Scaffold(
      appBar: AppBar(title: const Text('Radial Transition Demo')),
      body: Container(
        padding: const EdgeInsets.all(32.0),
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
  RadialExpansion(
      {Key? key, required this.minRadius, required this.maxRadius, this.child})
      : clipTween =
            Tween(begin: 2.0 * minRadius, end: 2.0 * (maxRadius / math.sqrt2)),
        super(key: key);

  final double minRadius;
  final double maxRadius;
  final Tween<double> clipTween;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        final double t =
            (size.biggest.width / 2.0 - minRadius) / (maxRadius - minRadius);
        final double rectClipExtent = clipTween.transform(t);
        return ClipOval(
          child: Center(
            child: SizedBox(
              width: rectClipExtent,
              height: rectClipExtent,
              child: ClipRect(child: child),
            ),
          ),
        );
      },
    );
  }
}
