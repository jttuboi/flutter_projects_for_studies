import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? won;
  final Function() onReset;

  ResultWidget({
    required this.won,
    required this.onReset,
  });

  @override
  Size get preferredSize => Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    // TODO precisará refatorar para evitar null
    Color? _getColor() {
      if (won == null) {
        return Colors.yellow;
      } else if (won!) {
        return Colors.green[300];
      }
      return Colors.red[300];
    }

    IconData? _getIcon() {
      if (won == null) {
        return Icons.sentiment_satisfied_outlined;
      } else if (won!) {
        return Icons.sentiment_very_satisfied_outlined;
      }
      return Icons.sentiment_very_dissatisfied_outlined;
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
