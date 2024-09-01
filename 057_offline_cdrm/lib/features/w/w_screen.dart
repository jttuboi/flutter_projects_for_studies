import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../widgets/button.dart';

class WScreen extends StatefulWidget {
  const WScreen({super.key});

  @override
  State<WScreen> createState() => _WScreenState();
}

class _WScreenState extends State<WScreen> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (_, i) {
        return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.amber,
          child: Column(
            children: [
              Text(i == 0
                  ? 'init ->'
                  : i == 1
                      ? 'p1 ->'
                      : 'p2'),
              if (i == 2) Button.label('save', onTap: () => Modular.to.navigate('/w/end')),
            ],
          ),
        );
      },
      itemCount: 3,
    );
  }
}
