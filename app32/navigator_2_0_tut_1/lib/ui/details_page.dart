import 'package:flutter/material.dart';
import 'package:navigator_2_0_tut_1/app_state.dart';
import 'package:navigator_2_0_tut_1/router/ui_pages.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage(this.id, {Key? key}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        title: Text(
          'Item $id',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  appState.addToCart('Item $id');
                  appState.currentAction = PageAction(state: PageState.pop);
                },
                child: const Text('Add to Cart'),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () => appState.currentAction = PageAction(state: PageState.addPage, page: CartPageConfig),
                child: const Text('Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
