import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shot_text/presentation/camera_shot/cubit/shot_result_cubit.dart';
import 'package:shot_text/presentation/camera_shot/theme.dart';
import 'package:shot_text/presentation/camera_shot/widgets/shot_result_error_view.dart';
import 'package:shot_text/presentation/camera_shot/widgets/shot_result_loading_view.dart';
import 'package:shot_text/presentation/camera_shot/widgets/shot_result_ready_view.dart';
import 'package:shot_text/presentation/camera_shot/widgets/show_result_settings_menu.dart';

class ShotResultPage extends StatelessWidget {
  const ShotResultPage({required this.imagePath, Key? key}) : super(key: key);

  static String routeName = '/result';

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShotResultCubit(imagePath: imagePath),
      child: const ShotResultView(),
    );
  }
}

class ShotResultView extends StatelessWidget {
  const ShotResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShotResultCubit, ShotResultState>(
      listener: (context, state) {
        if (state is ShotResultUrlNotOpenedReady) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Its not a allowed url: ${state.text}')));
        }
        if (state is ShotResultTextCopiedReady) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Text copied to clipboard: ${state.text}')));
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Text copied to clipboard.'),
                content: const Text('Do you want to exit?'),
                actions: [
                  TextButton(onPressed: () => Modular.to.pop(), style: textDialogButtonStyle, child: const Text('No')),
                  // OBS: SystemNavigator.pop() não funfa no iOS
                  TextButton(onPressed: SystemNavigator.pop, style: textDialogButtonStyle, child: const Text('Yes')),
                ],
                titleTextStyle: textDialogTitleStyle,
                contentTextStyle: textDialogContentStyle,
                backgroundColor: dialogBackgroundColor,
              );
            },
          );
        }
      },
      builder: (context, state) {
        if (state is ShotResultTextNotFound) {
          return ShotResultSettingsMenu(
            mainView: ShotResultErrorView(imagePath: state.imagePath),
          );
        }
        if (state is ShotResultTextLoading) {
          return ShotResultLoadingView(imagePath: state.imagePath);
        }
        return ShotResultSettingsMenu(
          mainView: ShotResultReadyView(imagePath: state.imagePath, text: (state as ShotResultTextReady).text),
        );
      },
    );
  }
}
