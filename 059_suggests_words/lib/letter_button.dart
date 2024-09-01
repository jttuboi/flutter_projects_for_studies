import 'package:flutter/material.dart';

class LetterButton extends StatefulWidget {
  const LetterButton(this.text, {required this.enabled, required this.onTap, super.key});

  final String text;
  final ValueNotifier<bool> enabled;
  final void Function(bool isSelected, String letter) onTap;

  @override
  State<LetterButton> createState() => _LetterButtonState();
}

class _LetterButtonState extends State<LetterButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: widget.enabled,
        builder: (_, enabled, ___) {
          return Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: isSelected
                  ? const BoxDecoration(color: Colors.blue, shape: BoxShape.circle)
                  : enabled
                      ? const BoxDecoration(color: Colors.black12, shape: BoxShape.circle)
                      : const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: isSelected
                    ? _changed
                    : enabled
                        ? _changed
                        : null,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.text.toUpperCase(),
                    style: isSelected
                        ? const TextStyle(fontSize: 18, fontFamily: 'Roboto Mono', fontWeight: FontWeight.bold, color: Colors.white)
                        : enabled
                            ? const TextStyle(fontSize: 18, fontFamily: 'Roboto Mono', fontWeight: FontWeight.bold)
                            : const TextStyle(fontSize: 18, fontFamily: 'Roboto Mono', fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _changed() {
    setState(() => isSelected = !isSelected);
    widget.onTap(isSelected, widget.text);
  }
}
