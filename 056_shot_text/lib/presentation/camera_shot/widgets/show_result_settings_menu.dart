import 'package:flutter/material.dart';

class ShotResultSettingsMenu extends StatelessWidget {
  const ShotResultSettingsMenu({required this.mainView, Key? key}) : super(key: key);

  final Widget mainView;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          mainView,
          Positioned(
            top: 0,
            right: 0,
            child: SafeArea(
              child: IconButton(
                onPressed: () => print('== settings'),
                icon: const Icon(Icons.more_vert_rounded),
                color: Colors.grey.shade300,
                padding: const EdgeInsets.all(16),
                iconSize: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
