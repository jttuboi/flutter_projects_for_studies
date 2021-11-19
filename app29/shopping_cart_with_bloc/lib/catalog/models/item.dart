// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopping_repository/shopping_repository.dart';

class Item extends Equatable {
  const Item(this.id, this.name, {this.color = Colors.white, this.price = 42});

  final int id;
  final String name;
  final Color color;
  final int price;

  @override
  List<Object> get props => [id, name, color, price];

  ItemApi toItemApi() {
    return ItemApi(id, name);
  }

  factory Item.fromItemApi(ItemApi e) {
    return Item(e.id, e.name, color: e.color, price: e.price);
  }
}
