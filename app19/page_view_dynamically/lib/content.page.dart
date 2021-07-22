import 'package:flutter/material.dart';
import 'package:page_view_dynamically/main.dart';

class Content extends StatelessWidget {
  const Content({Key? key, required this.pageNumber, required this.data})
      : super(key: key);

  final int pageNumber;
  final String data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints.expand(height: 300),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.amberAccent),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("page: $pageNumber, data: $data"),
                    duration: Duration(milliseconds: 300),
                  ),
                );
              },
              child: Text("top"),
            ),
          ),
          Container(
            constraints: BoxConstraints.expand(height: 300),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
              onPressed: () {},
              child: Text("page: $pageNumber, data: $data"),
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
