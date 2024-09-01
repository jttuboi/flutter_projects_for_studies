import 'package:flutter_test/flutter_test.dart';
import 'package:products/domain/utils.dart';

void main() {
  group('DateTimeExtension', () {
    test('converts to brazilian format data string', () {
      expect(DateTime(2001, 12, 31).toBrazilianFormat(), '31/12/2001');
      expect(DateTime(2001, 1, 2).toBrazilianFormat(), '02/01/2001');
    });
  });

  group('DoubleExtension', () {
    test('converts to brazilian format money string', () {
      expect(1.11.toBrazilianMoneyFormat(), r'R$1,11');
      expect(12.0.toBrazilianMoneyFormat(), r'R$12,00');
    });
  });
}
