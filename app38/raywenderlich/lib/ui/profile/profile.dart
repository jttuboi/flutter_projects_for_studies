import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raywenderlich/constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black, width: 1.0, style: BorderStyle.solid), borderRadius: BorderRadius.circular(10.0)),
          color: Colors.white,
          child: getProfileCard(context, index),
        );
      },
    );
  }

  Widget getProfileCard(BuildContext context, int index) {
    switch (index) {
      case 0:
        return ProfileCardTile(
          title: 'Personal Info',
          onTap: () => context.goNamed(personalRouteName),
        );
      case 1:
        return ProfileCardTile(
          title: 'Payment',
          onTap: () => context.goNamed(paymentRouteName),
        );
      case 2:
        return ProfileCardTile(
          title: 'Sign In Info',
          onTap: () => context.goNamed(signinInfoRouteName),
        );
    }
    return ProfileCardTile(
      title: 'More Info',
      onTap: () => context.goNamed(moreInfoRouteName),
    );
  }
}

class ProfileCardTile extends StatelessWidget {
  const ProfileCardTile({required this.title, this.onTap, Key? key}) : super(key: key);

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          onTap: onTap,
        ),
      ),
    );
  }
}
