import 'package:flutter/material.dart';
import 'package:manguinho/ui/components/components.dart';
import 'package:manguinho/ui/pages/pages.dart';
import 'package:provider/provider.dart';

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
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        widget.presenter.authenticationErrorStream.listen((messageError) {
          if (messageError.isNotEmpty) {
            showErrorMessage(context, messageError);
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
                child: Provider(
                  create: (_) => widget.presenter,
                  child: Form(
                    child: Column(
                      children: [
                        EmailInput(),
                        const SizedBox(height: 8),
                        PasswordInput(),
                        const SizedBox(height: 32),
                        LoginButton(),
                        TextButton.icon(onPressed: null, icon: Icon(Icons.person), label: Text('Criar conta')),
                      ],
                    ),
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
