import 'package:flutter/material.dart';

class Draw6 extends StatefulWidget {
  const Draw6({Key? key}) : super(key: key);

  @override
  _Draw5State createState() => _Draw5State();
}

class _Draw5State extends State<Draw6> {
  double _size = 50;

  @override
  Widget build(BuildContext context) {
    print("build Scaffold");
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _buildAnimationBox(),
          _buildListView(),
        ],
      ),
    );
  }

  Widget _buildAnimationBox() {
    return Container(
      color: Colors.pink,
      width: 200,
      height: 200,
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 5),
            width: _size,
            height: _size,
            color: Colors.teal,
          ),
          OutlinedButton(
            child: Text('Animate box'),
            onPressed: () => setState(() {
              _size = (_size == 50) ? 150 : 50;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return Expanded(
      // o list view tem RepaintBoundary()
      // por isso ao mexer nele, o AnimationContainer()
      // funciona sem interferencia da lista
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              height: 50,
              color: Colors.teal,
              child: Center(child: Text('Woolha.com')),
            ),
          );
          //return ListTile(title : Text('Item $index'),);
        },
      ),
    );
  }
}
