import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  LoadingButton(
    this.label, {
    Key? key,
    required this.busy,
    required this.invert,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final bool busy;
  final bool invert;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return busy
        ? Container(
            margin: EdgeInsets.only(bottom: 30.0),
            alignment: Alignment.center,
            height: 60,
            child: CircularProgressIndicator(backgroundColor: Colors.white),
          )
        : Container(
            margin: EdgeInsets.only(bottom: 30.0, left: 30.0, right: 30.0),
            height: 60.0,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: invert
                    ? Theme.of(context).primaryColor
                    : Colors.white.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                label,
                style: TextStyle(
                  color: invert ? Colors.white : Theme.of(context).primaryColor,
                  fontSize: 25.0,
                  fontFamily: 'Big Shoulders Display',
                ),
              ),
            ),
          );
  }
}
