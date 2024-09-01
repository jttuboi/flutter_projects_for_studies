import 'package:flutter/material.dart';

final theme = ThemeData(colorScheme: const ColorScheme.light().copyWith(secondary: Colors.grey.shade300));

final iconButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all(Colors.grey.shade300),
  backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
  overlayColor: MaterialStateProperty.all(Colors.white38),
  minimumSize: MaterialStateProperty.all(const Size(40, 40)),
  padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
);

final textButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all(Colors.grey.shade300),
  backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
  overlayColor: MaterialStateProperty.all(Colors.white38),
  minimumSize: MaterialStateProperty.all(const Size(40, 40)),
  padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
);

final textFieldStyle = TextStyle(color: Colors.grey.shade300, fontStyle: FontStyle.italic);

final textFieldBorder = UnderlineInputBorder(
  borderRadius: BorderRadius.circular(4),
  borderSide: BorderSide.none,
  // borderSide: BorderSide(color: Colors.grey.shade300),
);

final textFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.black.withOpacity(0.5),
  border: textFieldBorder,
  focusedBorder: textFieldBorder,
  enabledBorder: textFieldBorder,
);

final textDialogTitleStyle = TextStyle(color: Colors.grey.shade300, fontWeight: FontWeight.bold, fontSize: 18);

final textDialogContentStyle = TextStyle(color: Colors.grey.shade300);

final textDialogButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all(Colors.grey.shade300),
  backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
  overlayColor: MaterialStateProperty.all(Colors.white38),
  //minimumSize: MaterialStateProperty.all(const Size(40, 40)),
  padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
);

final dialogBackgroundColor = Colors.black.withOpacity(0.8);
