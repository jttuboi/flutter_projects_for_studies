import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  const NumberButton(this.number, {required this.selected, super.key});

  final int number;
  final ValueNotifier<int> selected;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: selected,
        builder: (_, numberSelected, ___) {
          return Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: numberSelected == number
                  ? const BoxDecoration(color: Colors.green, shape: BoxShape.circle)
                  : const BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  if (selected.value == number) {
                    selected.value = -1;
                  } else {
                    selected.value = number;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    (number + 1).toString(),
                    style: numberSelected == number
                        ? const TextStyle(fontSize: 18, fontFamily: 'Roboto Mono', fontWeight: FontWeight.bold, color: Colors.white)
                        : const TextStyle(fontSize: 18, fontFamily: 'Roboto Mono', fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
