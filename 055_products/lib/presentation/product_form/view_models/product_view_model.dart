import 'package:equatable/equatable.dart';
import 'package:products/domain/enums/product_type.dart';
import 'package:products/domain/models/product_model.dart';
import 'package:products/presentation/product_form/view_models/price.dart';
import 'package:products/presentation/product_form/view_models/title.dart';

class ProductViewModel extends Equatable {
  const ProductViewModel({
    required this.id,
    required this.title,
    required this.type,
    required this.price,
    required this.description,
    required this.rating,
    required this.picturePath,
  });

  final String id;
  final Title title;
  final ProductType type;
  final Price price;
  final String description;
  final double rating;
  final String picturePath;

  @override
  List<Object?> get props => [id, title, type, price, description, rating, picturePath];

  // ignore: sort_constructors_first
  factory ProductViewModel.fromProductModel(ProductModel product) {
    return ProductViewModel(
      id: product.id,
      title: Title(product.title),
      type: product.type,
      price: Price(product.price.toString().replaceFirst('.', ',')),
      description: product.description,
      rating: product.rating.toDouble(),
      picturePath: product.picturePath,
    );
  }

  ProductViewModel copyWith({
    String? id,
    Title? title,
    ProductType? type,
    Price? price,
    String? description,
    double? rating,
    String? picturePath,
  }) {
    return ProductViewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      price: price ?? this.price,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      picturePath: picturePath ?? this.picturePath,
    );
  }
}
