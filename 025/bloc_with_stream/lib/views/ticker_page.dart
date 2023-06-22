import 'package:bloc_with_stream/bloc/ticker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TickerPage extends StatelessWidget {
  const TickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc with streams')),
      body: Center(
        child: BlocBuilder<TickerBloc, TickerState>(
          builder: (context, state) {
            if (state is TickerTickSuccess) {
              return Text('Tick #${state.count}');
            }
            if (state is TickerComplete) {
              return const Text('Complete! Press the floating button to restart.');
            }
            return const Text('Press the floating button to start.');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<TickerBloc>().add(const TickerStarted()),
        tooltip: 'Start',
        child: const Icon(Icons.timer),
      ),
    );
  }
}
