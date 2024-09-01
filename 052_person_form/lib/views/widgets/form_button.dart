import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:person_form/views/bloc/person_form_bloc.dart';

class FormButton extends StatelessWidget {
  const FormButton({required FocusNode focusNode, Key? key})
      : _focusNode = focusNode,
        super(key: key);

  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonFormBloc, PersonFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          focusNode: _focusNode,
          onPressed: state.status.isValidated ? () => context.read<PersonFormBloc>().add(FormSubmitted()) : null,
          child: const Text('Salvar'),
        );
      },
    );
  }
}
