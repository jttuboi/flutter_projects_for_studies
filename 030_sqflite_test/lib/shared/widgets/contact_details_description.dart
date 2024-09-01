import 'package:flutter/widgets.dart';

class ContactDetailsDescription extends StatelessWidget {
  const ContactDetailsDescription({
    required this.name,
    required this.phone,
    required this.email,
    Key? key,
  }) : super(key: key);

  final String name;
  final String phone;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(phone, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        Text(email, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
