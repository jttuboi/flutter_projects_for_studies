import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_form/views/bloc/person_form_bloc.dart';

class NameField extends StatelessWidget {
  const NameField({required FocusNode focusNode, required FocusNode nextFocusNode, Key? key})
      : _nameFocusNode = focusNode,
        _nextFocusNode = nextFocusNode,
        super(key: key);

  final FocusNode _nameFocusNode;
  final FocusNode _nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonFormBloc, PersonFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.name.value,
          keyboardType: TextInputType.name,
          focusNode: _nameFocusNode,
          decoration: InputDecoration(
            labelText: 'Nome completo',
            helperText: 'Digite seu nome completo.',
            errorText: state.name.invalid ? 'Campo obrigatório.' : null,
          ),
          onChanged: (name) => context.read<PersonFormBloc>().add(NameChanged(name)),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).unfocus();
            if (state.birthday.invalid) {
              FocusScope.of(context).requestFocus(_nextFocusNode);
            }
          },
        );
      },
    );
  }
}
