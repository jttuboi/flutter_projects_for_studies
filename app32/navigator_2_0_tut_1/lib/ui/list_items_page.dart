import 'package:flutter/material.dart';
import 'package:navigator_2_0_tut_1/app_state.dart';
import 'package:navigator_2_0_tut_1/router/ui_pages.dart';
import 'package:navigator_2_0_tut_1/ui/details_page.dart';
import 'package:provider/provider.dart';

class ListItemsPage extends StatelessWidget {
  const ListItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    final items = List<String>.generate(10000, (i) => 'Item $i');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Items for sale',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => appState.currentAction = PageAction(state: PageState.addPage, page: SettingsPageConfig),
          ),
          IconButton(
            icon: const Icon(Icons.add_shopping_cart_sharp),
            onPressed: () => appState.currentAction = PageAction(state: PageState.addPage, page: CheckoutPageConfig),
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${items[index]}'),
              onTap: () {
                appState.currentAction =
                    PageAction(state: PageState.addWidget, widget: DetailsPage(index), page: DetailsPageConfig);
              },
            );
          },
        ),
      ),
    );
  }
}
