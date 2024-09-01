import 'package:flutter/material.dart';

enum RouteName {
  none('', Colors.transparent),
  l('/l', Colors.green),
  pr('/pr', Colors.green),
  hm('/hm', Colors.blueGrey),
  pf('/pf', Colors.brown),
  pl('/pl/:id', Colors.redAccent),
  sd('/sd', Colors.orangeAccent),
  hp('/hp', Colors.yellowAccent),
  hpd('/hp/:id', Colors.yellowAccent),
  f('/f', Colors.greenAccent),
  sl('/sl', Colors.cyanAccent),
  ht('/ht', Colors.blueAccent),
  c('/c', Colors.indigoAccent),

  ip('/ip', Color(0xFFE8EAF6)),
  s('/s', Color(0xFFC5CAE9)),
  fp('/fp', Color(0xFF7986CB)),
  cfp('/cfp', Color(0xFF7986CB)),
  ir('/ir', Color(0xFF3949AB)),
  cp('/cp', Color(0xFF303F9F)),
  tp('/tp', Color(0xFF5C6BC0)),

  sair('', Colors.black),
  aj('/aj', Colors.pinkAccent),
  tf('/tf', Colors.purpleAccent),
  tm('/tm', Colors.red),
  ;

  const RouteName(this.path, this.color);

  final String path;
  final Color color;
}
