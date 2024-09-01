import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_form/views/bloc/person_form_bloc.dart';

class BirthdayField extends StatelessWidget {
  BirthdayField({required FocusNode focusNode, required FocusNode nextFocusNode, Key? key})
      : _focusNode = focusNode,
        _nextFocusNode = nextFocusNode,
        super(key: key);

  final FocusNode _focusNode;
  final FocusNode _nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonFormBloc, PersonFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.birthday.value,
          keyboardType: TextInputType.datetime,
          focusNode: _focusNode,
          decoration: InputDecoration(
            labelText: 'dd/mm/yyyy',
            helperText: 'Digite sua data de aniversário.',
            errorText: state.birthday.invalid ? 'Campo obrigatório.' : null,
          ),
          onChanged: (birthday) => context.read<PersonFormBloc>().add(BirthdayChanged(birthday)),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).unfocus();
            if (state.gender.invalid) {
              FocusScope.of(context).requestFocus(_nextFocusNode);
            }
          },
        );
      },
    );
  }
}
