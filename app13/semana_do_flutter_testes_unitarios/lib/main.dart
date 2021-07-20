import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:semana_do_flutter_testes_unitarios/bloc_provider.dart';
import 'package:semana_do_flutter_testes_unitarios/home_page.dart';
import 'package:semana_do_flutter_testes_unitarios/person_bloc.dart';
import 'package:semana_do_flutter_testes_unitarios/person_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        bloc: PersonBloc(
          PersonRepository(Client()),
        ),
        child: HomePage(),
      ),
    );
  }
}
