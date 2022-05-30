import 'package:flutter/material.dart';
import 'package:raywenderlich/widgets/j_app_bar.dart';
import 'cart.dart';
import 'profile.dart';
import 'shopping.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({required String tab, Key? key})
      : index = indexFrom(tab),
        super(key: key);

  final int index;

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static int indexFrom(String tab) {
    switch (tab) {
      case 'cart':
        return 1;
      case 'profile':
        return 2;
      case 'shopping':
      default:
        return 0;
    }
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppBar(title: 'Navigator'),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        backgroundColor: Colors.blue,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: (index) => setState(() {
          _selectedIndex = index;
          // TODO: Add Switch
        }),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          Shopping(),
          Cart(),
          Profile(),
        ],
      ),
    );
  }
}
