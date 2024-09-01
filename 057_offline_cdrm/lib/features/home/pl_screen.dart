import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/route_name.dart';
import 'pl_cubit.dart';
import 'screen_with_menu.dart';

class PlScreen extends StatefulWidget {
  PlScreen({required this.userId, PlCubit? cubit, super.key}) : _cubit = cubit ?? Modular.get<PlCubit>();

  final PlCubit _cubit;
  final String userId;

  @override
  State<PlScreen> createState() => _PlScreenState();
}

class _PlScreenState extends State<PlScreen> with AfterLayoutMixin<PlScreen> {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    widget._cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlCubit>(
      create: (_) => widget._cubit,
      child: PlView(userId: widget.userId),
    );
  }
}

class PlView extends StatelessWidget {
  const PlView({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return ScreenWithMenu(RouteName.pl, contents: [
      Text(userId),
    ]);
  }
}
