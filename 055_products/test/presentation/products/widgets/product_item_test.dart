import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:products/presentation/products/view_models/product_view_model.dart';
import 'package:products/presentation/products/widgets/product_item.dart';

void main() {
  group('ProductItem', () {
    testWidgets('renders properly', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ProductItem(productViewModel, onEditPressed: () {}, onDeletePressed: () {})));

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
      expect(find.text('type'), findsOneWidget);
      expect(find.text('created'), findsOneWidget);
      expect(find.byIcon(Icons.grade_rounded), findsNWidgets(5));
      expect(tester.widget<Icon>(find.byIcon(Icons.grade_rounded).at(0)).color, Colors.deepPurple);
      expect(tester.widget<Icon>(find.byIcon(Icons.grade_rounded).at(1)).color, Colors.grey.shade400);
      expect(tester.widget<Icon>(find.byIcon(Icons.grade_rounded).at(2)).color, Colors.grey.shade400);
      expect(tester.widget<Icon>(find.byIcon(Icons.grade_rounded).at(3)).color, Colors.grey.shade400);
      expect(tester.widget<Icon>(find.byIcon(Icons.grade_rounded).at(4)).color, Colors.grey.shade400);
      expect(find.byIcon(Icons.more_horiz_rounded), findsOneWidget);
      expect(find.text('price'), findsOneWidget);

      expect(find.text('Edit'), findsNothing);
      expect(find.text('Delete'), findsNothing);
    });

    testWidgets('shows popup menu item edit delete when clicks on button with Icons.more_horiz_rounded', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ProductItem(productViewModel, onEditPressed: () {}, onDeletePressed: () {})));

      await tester.tap(find.byIcon(Icons.more_horiz_rounded));
      await tester.pump();

      expect(find.byIcon(Icons.more_horiz_rounded), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('activates onEditPressed when clicks on Edit button', (tester) async {
      var editClicked = false;
      await tester.pumpWidget(MaterialApp(
        home: ProductItem(
          productViewModel,
          onEditPressed: () => editClicked = true,
          onDeletePressed: () {},
        ),
      ));

      await tester.tap(find.byIcon(Icons.more_horiz_rounded));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Edit'));
      await tester.pump();

      expect(editClicked, isTrue);
    });

    testWidgets('activates onDeletePressed when clicks on Delete button', (tester) async {
      var deleteClicked = false;
      await tester.pumpWidget(MaterialApp(
        home: ProductItem(
          productViewModel,
          onEditPressed: () {},
          onDeletePressed: () => deleteClicked = true,
        ),
      ));

      await tester.tap(find.byIcon(Icons.more_horiz_rounded));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Delete'));
      await tester.pump();

      expect(deleteClicked, isTrue);
    });
  });
}

const productViewModel = ProductViewModel(
  id: 'id',
  filename: 'empty_picture.png',
  title: 'title',
  type: 'type',
  created: 'created',
  rating: 1,
  emptiesRating: 4,
  price: 'price',
  picturePath: 'picturePath',
);
