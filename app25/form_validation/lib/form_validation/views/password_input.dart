import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/form_validation/bloc/form_validation_bloc.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormValidationBloc, FormValidationState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.lock),
            labelText: 'Password',
            helperText: 'Password should be at least 8 characters with at least one letter and number',
            helperMaxLines: 2,
            errorText: state.password.invalid ? 'Password must be at least 8 characters and contain at least one letter and number' : null,
            errorMaxLines: 2,
          ),
          obscureText: true,
          onChanged: (value) => context.read<FormValidationBloc>().add(PasswordChanged(password: value)),
          textInputAction: TextInputAction.done,
        );
      },
    );
  }
}
