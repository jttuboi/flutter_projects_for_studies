import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shot_text/domain/exceptions/url_not_launched_exception.dart';
import 'package:shot_text/domain/services/converter_image_to_text_service.dart';
import 'package:shot_text/domain/services/share_service.dart';
import 'package:shot_text/domain/services/url_launcher_service.dart';

part 'shot_result_state.dart';

class ShotResultCubit extends Cubit<ShotResultState> {
  ShotResultCubit({
    required this.imagePath,
    IConverterImageToTextService? converterImageToTextService,
    IUrlLauncherService? urlLauncherService,
    IShareService? shareService,
  })  : converterImageToTextService = converterImageToTextService ?? Modular.get<IConverterImageToTextService>(),
        urlLauncherService = urlLauncherService ?? Modular.get<IUrlLauncherService>(),
        shareService = shareService ?? Modular.get<IShareService>(),
        super(ShotResultInitial(imagePath)) {
    loaded();
  }

  final String imagePath;
  final IConverterImageToTextService converterImageToTextService;
  final IUrlLauncherService urlLauncherService;
  final IShareService shareService;

  Future<void> loaded() async {
    emit(ShotResultTextLoading(imagePath));

    final text = await converterImageToTextService.convert(File(imagePath));

    if (text.isEmpty) {
      emit(ShotResultTextNotFound(imagePath));
    } else {
      emit(ShotResultTextReady(imagePath, text));
    }
  }

  Future<void> urlOpened(String textEdited) async {
    try {
      await urlLauncherService.launch(textEdited);
    } on UrlNotLaunchedException {
      emit(ShotResultUrlNotOpenedReady(state.imagePath, textEdited));
    }
  }

  Future<void> textCopied(String textEdited) async {
    await Clipboard.setData(ClipboardData(text: textEdited));
    emit(ShotResultTextCopiedReady(state.imagePath, textEdited));
  }

  Future<void> textShared(String textEdited) async {
    await shareService.share(textEdited);
  }
}
