import 'package:flutter/material.dart';
import 'package:raywenderlich/widgets/j_app_bar.dart';

class MoreInfo extends StatefulWidget {
  const MoreInfo({Key? key}) : super(key: key);

  @override
  _MoreInfoState createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppBar(title: 'More Info'),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MoreInfoCard(title: 'Help Center'),
            MoreInfoCard(title: 'Rate the App'),
          ],
        ),
      ),
    );
  }
}

class MoreInfoCard extends StatelessWidget {
  const MoreInfoCard({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black, width: 1.0, style: BorderStyle.solid), borderRadius: BorderRadius.circular(10.0)),
      color: Colors.white,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
