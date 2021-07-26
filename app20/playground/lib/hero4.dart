import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Hero5Page extends StatelessWidget {
  static double kMinRadius = 32.0;
  static double kMaxRadius = 128.0;
  static Interval opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  static RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  static Widget _buildPage(context, String imageUrl, String description) {
    return Container(
      color: Theme.of(context).canvasColor,
      alignment: FractionalOffset.center,
      child: SizedBox(
        width: kMaxRadius * 2.0,
        height: kMaxRadius * 2.0,
        child: Hero(
          createRectTween: _createRectTween,
          tag: imageUrl,
          child: RadialExpansion(
            maxRadius: kMaxRadius,
            child: Photo(
              imageUrl: imageUrl,
              onTap: () => Navigator.of(context).pop(),
            ),
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
          child: Photo(
            imageUrl: imageUrl,
            onTap: () {
              Navigator.of(context).push(
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
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 20.0; // 1.0 is normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Radial Hero Animation Demo'),
      ),
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
  const Photo({Key? key, required this.imageUrl, this.color, this.onTap})
      : super(key: key);

  final String imageUrl;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      // Slightly opaque color appears where the image has transparency.
      // Makes it possible to see the radial transformation's boundary.
      color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: InkWell(
        onTap: onTap,
        child: Image.asset(imageUrl, fit: BoxFit.contain),
      ),
    );
  }
}

class RadialExpansion extends StatelessWidget {
  const RadialExpansion({Key? key, required this.maxRadius, this.child})
      : clipRectExtent = 2.0 * (maxRadius / math.sqrt2),
        super(key: key);

  final double maxRadius;
  final double clipRectExtent;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // The ClipOval matches the RadialExpansion widget's bounds,
    // which change per the Hero's bounds as the Hero flies to
    // the new route, while the ClipRect's bounds are always fixed.
    return ClipOval(
      child: Center(
        child: SizedBox(
          width: clipRectExtent,
          height: clipRectExtent,
          child: ClipRect(child: child),
        ),
      ),
    );
  }
}
