import 'package:flutter/material.dart';

class Design5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("use themes")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(child: Text("using theme"), onPressed: () {}),
            ElevatedButtonTheme(
              data: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  textStyle: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "Hind",
                    color: Colors.green, // doesn't work
                  ),
                  side: BorderSide(color: Colors.black, width: 1.5),
                ),
              ),
              child: ElevatedButton(
                  child: Text("using unique theme"), onPressed: () {}),
            ),
          ],
        ),
      ),
      floatingActionButton: Theme(
        // sample of extended theme
        data: Theme.of(context).copyWith(
          colorScheme:
              Theme.of(context).colorScheme.copyWith(secondary: Colors.yellow),
        ),
        child: FloatingActionButton(onPressed: null, child: Icon(Icons.add)),
      ),
    );
  }
}
