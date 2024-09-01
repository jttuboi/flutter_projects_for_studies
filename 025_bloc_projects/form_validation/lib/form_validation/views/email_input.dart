import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/form_validation/bloc/form_validation_bloc.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    // atualiza o conteúdo independente do state que estiver
    return BlocBuilder<FormValidationBloc, FormValidationState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.email),
            labelText: 'Email',
            helperText: 'A complete, valid email e.g. a@a.com',
            errorText: state.email.invalid ? 'Please ensure the email entered is valid' : null,
          ),
          keyboardType: TextInputType.emailAddress,
          // chama a cada modificação feita no text field
          onChanged: (value) => context.read<FormValidationBloc>().add(EmailChanged(email: value)),
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}
