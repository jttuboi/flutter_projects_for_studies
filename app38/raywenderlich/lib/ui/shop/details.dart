import 'package:flutter/material.dart';
import 'package:raywenderlich/widgets/j_app_bar.dart';
import 'package:raywenderlich/widgets/j_elevated_button.dart';
import '../../cart_holder.dart';
import 'package:provider/provider.dart';

class Details extends StatelessWidget {
  const Details({required this.description, Key? key}) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppBar(title: 'Details'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(description),
            const SizedBox(height: 20.0),
            JElevatedButton(
              title: 'Add To Cart',
              style: JElevatedButtonStyle.primaryColor,
              textStyle: JElevatedButtonTextStyle.white,
              onPressed: () {
                Provider.of<CartHolder>(context, listen: false).addItem(description);
                // TODO: Add Root Route
              },
            ),
          ],
        ),
      ),
    );
  }
}
