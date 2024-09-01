import 'package:equatable/equatable.dart';

import 'package:products/domain/enums/product_type.dart';
import 'package:products/domain/utils.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.filename,
    required this.price,
    required this.rating,
    required this.created,
    this.picturePath = '', // default is empty
  });

  final String id;
  final String title;
  final ProductType type;
  final String description;
  final String filename;
  final double price;
  final int rating;
  final DateTime created;
  final String picturePath;

  @override
  List<Object?> get props => [id, title, type, description, filename, price, rating, created, picturePath];

  // ignore: sort_constructors_first
  factory ProductModel.fromMap(String id, Map<String, dynamic> map) {
    return ProductModel(
      id: id,
      title: map[ProductModelMap.title] ?? '',
      type: toProductType(map[ProductModelMap.type]),
      description: map[ProductModelMap.description] ?? '',
      filename: map[ProductModelMap.filename] ?? '',
      price: map[ProductModelMap.price]?.toDouble() ?? 0.0,
      rating: map[ProductModelMap.rating]?.toInt() ?? 0,
      created: DateTime.fromMillisecondsSinceEpoch(map[ProductModelMap.created] ?? 0),
    );
  }

  Map<String, dynamic> toMap(DateTime dateTimeNow) {
    return {
      ProductModelMap.title: title,
      ProductModelMap.type: type.toShortString(),
      ProductModelMap.description: description,
      ProductModelMap.filename: filename,
      ProductModelMap.price: price,
      ProductModelMap.rating: rating,
      ProductModelMap.created: dateTimeNow.millisecondsSinceEpoch,
    };
  }

  ProductModel copyWith({
    String? id,
    String? title,
    ProductType? type,
    String? description,
    String? filename,
    double? price,
    int? rating,
    DateTime? created,
    String? picturePath,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      filename: filename ?? this.filename,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      created: created ?? this.created,
      picturePath: picturePath ?? this.picturePath,
    );
  }
}
