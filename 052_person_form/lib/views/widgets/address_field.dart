import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_form/views/bloc/person_form_bloc.dart';

class AddressField extends StatelessWidget {
  const AddressField({required FocusNode focusNode, required FocusNode nextFocusNode, Key? key})
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
          initialValue: state.address.value,
          focusNode: _focusNode,
          decoration: InputDecoration(
            labelText: 'Endereço',
            helperText: 'Colocar o nome do local onde mora.',
            helperMaxLines: 2,
            errorText: state.address.invalid ? 'Campo obrigatório.' : null,
            errorMaxLines: 2,
          ),
          onChanged: (address) => context.read<PersonFormBloc>().add(AddressChanged(address)),
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(_nextFocusNode);
          },
        );
      },
    );
  }
}
