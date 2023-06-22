import 'package:shopping_repository/src/models/item_api.dart';

const _delay = Duration(milliseconds: 800);

const _catalog = [
  'Code Smell',
  'Control Flow',
  'Interpreter',
  'Recursion',
  'Sprint',
  'Heisenbug',
  'Spaghetti',
  'Hydra Code',
  'Off-By-One',
  'Scope',
  'Callback',
  'Closure',
  'Automata',
  'Bit Shift',
  'Currying',
];

class ShoppingRepository {
  final _items = <ItemApi>[];

  Future<List<String>> loadCatalog() => Future.delayed(_delay, () => _catalog);

  Future<List<ItemApi>> loadCartItems() => Future.delayed(_delay, () => _items);

  void addItemToCart(ItemApi item) => _items.add(item);

  void removeItemFromCart(ItemApi item) => _items.remove(item);
}
