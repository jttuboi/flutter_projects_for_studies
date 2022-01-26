import 'package:flutter/material.dart';
import 'package:nav2_flutter_community/common/dimens/app_dimens.dart';
import 'package:nav2_flutter_community/viewmodels/auth_view_model.dart';
import 'package:nav2_flutter_community/widgets/in_progress_message.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({required this.onLogin, Key? key}) : super(key: key);

  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    return Center(
      child: authViewModel.logingIn
          // caso o usuario deslogue diretamente do LoginScreen, ele atualiza a tela
          // e substitui por essa mensagem de estar deslogando
          ? InProgressMessage(progressName: "Login", screenName: "LoginScreen")
          : ElevatedButton(
              // se clicou no botão e consegue logar no servidor, ele fala que conseguiu logar na pagina
              onPressed: () async {
                final authViewModel = context.read<AuthViewModel>();
                final result = await authViewModel.login();
                if (result == true) {
                  onLogin();
                } else {
                  authViewModel.logingIn = false;
                }
              },
              child: Padding(
                padding: EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
                child: Text('Log in'),
              ),
            ),
    );
  }
}
