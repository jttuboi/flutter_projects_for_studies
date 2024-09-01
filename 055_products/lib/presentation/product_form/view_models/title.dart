import 'package:equatable/equatable.dart';
import 'package:products/presentation/product_form/enums/status.dart';

class Title extends Equatable {
  const Title(this.value, [this._status = Status.ready]);

  final String value;
  final Status _status;

  @override
  List<Object?> get props => [value, _status];

  Title ready() {
    return Title(value);
  }

  Title changing(String newValue) {
    return Title(newValue, Status.changing);
  }

  bool get isValid {
    // only liberate to check if it is valid after status be ready
    if (_status.isChanging) {
      return true;
    }

    return value.isNotEmpty;
  }
}
