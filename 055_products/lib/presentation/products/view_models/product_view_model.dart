import 'package:equatable/equatable.dart';
import 'package:products/domain/enums/product_type.dart';
import 'package:products/domain/models/product_model.dart';
import 'package:products/domain/utils.dart';

class ProductViewModel extends Equatable {
  const ProductViewModel({
    required this.id,
    required this.filename,
    required this.picturePath,
    required this.title,
    required this.type,
    required this.created,
    required this.rating,
    required this.emptiesRating,
    required this.price,
  });

  final String id;
  final String filename;
  final String picturePath;
  final String title;
  final String type;
  final String created;
  final int rating;
  final int emptiesRating;
  final String price;

  @override
  List<Object?> get props => [id, filename, title, type, created, rating, emptiesRating, price];

  // ignore: sort_constructors_first
  factory ProductViewModel.fromProductModel(ProductModel product) {
    return ProductViewModel(
      id: product.id,
      filename: product.filename,
      picturePath: product.picturePath,
      title: product.title,
      type: product.type.toStringName(),
      created: product.created.toBrazilianFormat(),
      rating: product.rating,
      emptiesRating: 5 - product.rating,
      price: product.price.toBrazilianMoneyFormat(),
    );
  }
}
