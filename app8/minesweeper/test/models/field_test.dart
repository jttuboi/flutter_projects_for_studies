import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/models/field.dart';

main() {
  group("Field", () {
    test("open field with explosion", () {
      Field f = Field(row: 0, column: 0);
      f.mine();

      expect(f.open, throwsException);
    });

    test("open field without explosion", () {
      Field f = Field(row: 0, column: 0);
      f.open();

      expect(f.opened, isTrue);
    });

    test("add no neighbor", () {
      Field f1 = Field(row: 0, column: 0);
      Field f2 = Field(row: 1, column: 3);
      f1.addNeighbor(f2);

      expect(f1.neighbors.isEmpty, isTrue);
    });

    test("add neighbor", () {
      Field f1 = Field(row: 3, column: 3);
      Field f2 = Field(row: 3, column: 4);
      Field f3 = Field(row: 2, column: 2);
      Field f4 = Field(row: 4, column: 4);
      f1.addNeighbor(f2);
      f1.addNeighbor(f3);
      f1.addNeighbor(f4);

      expect(f1.neighbors.length, 3);
    });

    test("neighbor has mine", () {
      Field f1 = Field(row: 3, column: 3);
      Field f2 = Field(row: 3, column: 4);
      Field f3 = Field(row: 2, column: 2);
      Field f4 = Field(row: 4, column: 4);
      f2.mine();
      f4.mine();
      f1.addNeighbor(f2);
      f1.addNeighbor(f3);
      f1.addNeighbor(f4);

      expect(f1.quantityNeighborMines, 2);
    });
  });
}
