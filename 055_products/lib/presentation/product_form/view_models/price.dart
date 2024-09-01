import 'package:equatable/equatable.dart';
import 'package:products/presentation/product_form/enums/status.dart';

class Price extends Equatable {
  const Price(this.value, [this._status = Status.ready]);

  final String value;
  final Status _status;

  @override
  List<Object?> get props => [value, _status];

  Price ready() {
    return Price(value);
  }

  Price changing(String newValue) {
    return Price(newValue, Status.changing);
  }

  bool get isValid {
    // only liberate to check if it is valid after status be ready
    if (_status.isChanging) {
      return true;
    }

    if (value.isNotEmpty && _isDouble) {
      return true;
    }
    return false;
  }

  bool get _isDouble => double.tryParse(value.replaceAll(',', '.')) != null;

  double toDouble() {
    return double.parse(value.replaceAll(',', '.'));
  }
}
