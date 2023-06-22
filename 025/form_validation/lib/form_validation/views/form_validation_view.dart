import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/form_validation/bloc/form_validation_bloc.dart';
import 'package:form_validation/form_validation/views/email_input.dart';
import 'package:form_validation/form_validation/views/password_input.dart';
import 'package:form_validation/form_validation/views/submit_button.dart';
import 'package:form_validation/form_validation/views/success_dialog.dart';
import 'package:formz/formz.dart';

class FormValidationView extends StatefulWidget {
  const FormValidationView({Key? key}) : super(key: key);

  @override
  _FormValidationViewState createState() => _FormValidationViewState();
}

class _FormValidationViewState extends State<FormValidationView> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        // quando o campo de email pede foco, ele fala pro bloc que foi tirado o foco
        context.read<FormValidationBloc>().add(EmailUnfocused());
        // manda o foco para o password
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        // fala para que o password perdeu foco, assim atualizando os campos caso
        // o password esteja invalido
        context.read<FormValidationBloc>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Validation')),
      // utilizado apenas para ouvir, nesse caso o child não é atualizado
      // apenas tudo que está dentro do listener
      body: BlocListener<FormValidationBloc, FormValidationState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showDialog<void>(
              context: context,
              builder: (context) => const SuccessDialog(),
            );
          }
          if (state.status.isSubmissionInProgress) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Submitting...')),
              );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              EmailInput(focusNode: _emailFocusNode),
              PasswordInput(focusNode: _passwordFocusNode),
              const SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
