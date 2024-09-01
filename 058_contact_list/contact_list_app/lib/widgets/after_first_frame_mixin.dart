import 'dart:async';

import 'package:flutter/widgets.dart';

// /////////////////////////////////////////////////////////////////////////////
//
// por ser bem simples, copiado diretamente dos packages abaixo para evitar ter q adicionar mais um package no projeto.
// os packages abaixo são similares, só muda o nome e quem o publicou. então tanto faz de quem foi pego.
//
// https://pub.dev/packages/after_first_frame_mixin
// https://pub.dev/packages/after_layout
//
// /////////////////////////////////////////////////////////////////////////////

mixin AfterFirstFrameMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted) afterFirstFrame(context);
      },
    );
  }

  FutureOr<void> afterFirstFrame(BuildContext context);
}
