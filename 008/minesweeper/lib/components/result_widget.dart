import 'package:flutter/material.dart';
import 'package:minesweeper/components/game_state.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final GameState gameState;
  final Function() onReset;

  ResultWidget({
    required this.gameState,
    required this.onReset,
  });

  @override
  Size get preferredSize => Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    Color? _getColor() {
      switch (gameState) {
        case GameState.RUNNING:
          return Colors.yellow;
        case GameState.WON:
          return Colors.green[300];
        case GameState.ENDED:
          return Colors.red[300];
      }
    }

    IconData? _getIcon() {
      switch (gameState) {
        case GameState.RUNNING:
          return Icons.sentiment_satisfied_outlined;
        case GameState.WON:
          return Icons.sentiment_very_satisfied_outlined;
        case GameState.ENDED:
          return Icons.sentiment_very_dissatisfied_outlined;
      }
    }

    return Container(
      color: Colors.grey,
      child: SafeArea(
        // add a space between the child of this and the top of screen. this space
        // avoids the child hide by cellphone system like as icons, clock, camera, etc
        child: Container(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
              onPressed: onReset,
            ),
          ),
        ),
      ),
    );
  }
}
