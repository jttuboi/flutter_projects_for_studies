import 'package:bloc/bloc.dart';
import 'package:counter/app.dart';
import 'package:counter/counter_observer.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(const CounterApp());
}
