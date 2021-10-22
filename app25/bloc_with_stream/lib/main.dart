import 'package:bloc_with_stream/bloc/ticker_bloc.dart';
import 'package:bloc_with_stream/models/ticker.dart';
import 'package:bloc_with_stream/views/ticker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(App());

class App extends MaterialApp {
  App({Key? key})
      : super(
          key: key,
          home: BlocProvider<TickerBloc>(
            create: (context) => TickerBloc(Ticker()),
            child: const TickerPage(),
          ),
        );
}
