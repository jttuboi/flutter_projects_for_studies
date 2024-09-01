import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search_city_by_cep/home_page.dart';
import 'package:search_city_by_cep/search_cep_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => Dio()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SearchCepBloc(context.read<Dio>())),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );
  }
}
