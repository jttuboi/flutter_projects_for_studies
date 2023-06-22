import 'package:flutter/material.dart';
import 'package:nav2_lulupointu/app_1_simple_route.dart';
import 'package:nav2_lulupointu/app_2_nested_route.dart';
import 'package:nav2_lulupointu/app_3_transitions.dart';
import 'package:nav2_lulupointu/app_4_routes_plus_bloc.dart';

void main() {
  // https://lucasdelsol01.medium.com/flutter-navigator-2-0-101-for-mobile-dev-5094566613f6
  // esse explica o básico de uma route
  // runApp(const App1());

  // https://lucasdelsol01.medium.com/flutter-navigator-2-0-for-mobile-dev-nested-navigators-basics-2dab6c55010e
  // esse tutorial explica um pouco como é nested routes
  // MASSSSSSSSSSSSSS
  // - é difícil entender o que está acontecendo com o BackButton
  // - ele utiliza o package MoveToBackground que não é recomendado para iOS (ver no package para entender mais)
  // - o comportamento ao clicar no botão do BackButton do android quando está na home page em qualquer
  //   uma das tabs é sair do app e o ideal é voltar pelo menos ao authentication page
  // - a parte visual está completamente misturado com o RouterDelegate (o Scaffold está dentro do RouterDelegate)
  //   sendo que um dos propósito é tirar responsa do visual cuidar da navegação e aqui está dando a responsabilidade
  //   da navegação ter partes visuais internamente
  // runApp(const App2());

  // https://lucasdelsol01.medium.com/flutter-navigator-2-0-for-mobile-dev-transitions-1967b79aaa37
  // esse explica como fazer uma animação na transição com a criação de Pages
  // runApp(const App3());

  // https://lucasdelsol01.medium.com/flutter-navigator-2-0-for-mobile-dev-bloc-state-management-integration-3a180b4d25b3
  // exxe mpstra router + bloc
  runApp(const App4());
}
