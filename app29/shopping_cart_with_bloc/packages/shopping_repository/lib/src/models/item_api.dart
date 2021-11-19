import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ItemApi extends Equatable {
  ItemApi(this.id, this.name) : color = Colors.primaries[id % Colors.primaries.length];

  final int id;
  final String name;
  final Color color;
  final int price = 42;

  @override
  List<Object> get props => [id, name, color, price];
}
