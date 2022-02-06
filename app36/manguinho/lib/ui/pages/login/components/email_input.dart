import 'package:flutter/material.dart';
import 'package:manguinho/ui/pages/pages.dart';
import 'package:provider/provider.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<String?>(
        stream: presenter.emailErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: presenter.validateEmail,
          );
        });
  }
}
