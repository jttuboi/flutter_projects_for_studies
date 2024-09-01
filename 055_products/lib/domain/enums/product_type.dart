enum ProductType {
  bakery,
  dairy,
  fruit,
  meat,
  vegan,
  vegetable,
  unknown,
}

extension ProductTypeExtension on ProductType {
  bool get isUnknown => this == ProductType.unknown;

  String toStringName() {
    switch (this) {
      case ProductType.bakery:
        return 'Bakery';
      case ProductType.dairy:
        return 'Dairy';
      case ProductType.fruit:
        return 'Fruit';
      case ProductType.meat:
        return 'Meat';
      case ProductType.vegan:
        return 'Vegan';
      case ProductType.vegetable:
        return 'Vegetable';
      case ProductType.unknown:
        return '';
    }
  }

  String toShortString() {
    return toString().split('.').last;
  }
}

ProductType toProductType(String productTypeString) {
  switch (productTypeString) {
    case 'bakery':
      return ProductType.bakery;
    case 'dairy':
      return ProductType.dairy;
    case 'fruit':
      return ProductType.fruit;
    case 'meat':
      return ProductType.meat;
    case 'vegan':
      return ProductType.vegan;
    case 'vegetable':
      return ProductType.vegetable;
  }
  return ProductType.unknown;
}
