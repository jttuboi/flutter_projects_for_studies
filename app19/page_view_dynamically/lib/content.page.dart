import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({Key? key, required this.pageNumber}) : super(key: key);

  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints.expand(height: 300),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.amberAccent),
              onPressed: () {},
              child: Text("top"),
            ),
          ),
          Container(
            constraints: BoxConstraints.expand(height: 300),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
              onPressed: () {},
              child: Text("page: $pageNumber"),
            ),
          ),
          Container(
            constraints: BoxConstraints.expand(height: 300),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.cyanAccent),
              onPressed: () {},
              child: Text("bottom"),
            ),
          ),
        ],
      ),
    );
  }
}
