import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/form_validation/bloc/form_validation_bloc.dart';
import 'package:formz/formz.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormValidationBloc, FormValidationState>(
      // atuazliza o build apenas quando muda de status, ou seja,
      // se o estado ainda está invalido e mudar para valido, ele atualiza
      // o mesmo se dá quando invalido e muda pra valido, ele atualiza
      // assim consegue um controle sobre o onPressed pelo
      // status.isValidated
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          // quando clica, fala que o form foi submetido
          onPressed: state.status.isValidated ? () => context.read<FormValidationBloc>().add(FormSubmitted()) : null,
          child: const Text('Submit'),
        );
      },
    );
  }
}
