import 'package:flutter/material.dart';
import 'package:manguinho/ui/components/components.dart';
import 'package:manguinho/ui/pages/pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage(this.presenter, {Key? key}) : super(key: key);

  final LoginPresenter presenter;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        widget.presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return SimpleDialog(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text('Aguarde ...', textAlign: TextAlign.center),
                      ],
                    )
                  ],
                );
              },
            );
          } else {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          }
        });

        widget.presenter.authenticationErrorStream.listen((messageError) {
          if (messageError.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(messageError, textAlign: TextAlign.center),
              backgroundColor: Colors.red[900],
            ));
          }
        });

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoginHeader(),
              Headline1('LOGIN'),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  child: Column(
                    children: [
                      StreamBuilder<String?>(
                          stream: widget.presenter.emailErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
                                errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: widget.presenter.validateEmail,
                            );
                          }),
                      const SizedBox(height: 8),
                      StreamBuilder<String?>(
                          stream: widget.presenter.passwordErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                                errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                              ),
                              obscureText: true,
                              onChanged: widget.presenter.validatePassword,
                            );
                          }),
                      const SizedBox(height: 32),
                      StreamBuilder<bool>(
                          stream: widget.presenter.isFormValidStream,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed: snapshot.data == true ? widget.presenter.auth : null,
                              child: Text('Entrar'),
                            );
                          }),
                      TextButton.icon(onPressed: null, icon: Icon(Icons.person), label: Text('Criar conta')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
