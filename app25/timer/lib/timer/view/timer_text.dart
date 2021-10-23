import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/timer/bloc/timer_bloc.dart';

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // só atualiza o widget onde o select está sendo chamado, nesse caso, dentro desse build
    // é igual um watch, ele ouve parcialmente as alterações, nesse caso ele apenas ouve alterações da duration
    final duration = context.select<TimerBloc, int>((bloc) => bloc.state.duration);
    final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');

    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
