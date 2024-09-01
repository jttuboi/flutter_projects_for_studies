const jsonFakeDatabasePath = 'assets/database/products.json';

const productsPath = 'products/';

const assetsImageFolderPath = 'assets/images/';
const emptyPicture = 'empty_picture.png';

class ProductModelMap {
  static const title = 'title';
  static const type = 'type';
  static const description = 'description';
  static const filename = 'filename';
  static const price = 'price';
  static const rating = 'rating';
  static const created = 'created';
}

extension DateTimeExtension on DateTime {
  String toBrazilianFormat() {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
  }
}

extension DoubleExtension on double {
  String toBrazilianMoneyFormat() {
    // ignore: prefer_final_locals
    var parts = toString().split('.');

    if (parts[1].length == 1) {
      parts[1] = parts[1].padRight(2, '0');
    }

    return 'R\$${parts[0]},${parts[1]}';
  }
}
