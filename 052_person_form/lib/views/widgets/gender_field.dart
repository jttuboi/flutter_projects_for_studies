import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_form/views/bloc/person_form_bloc.dart';

class GenderField extends StatelessWidget {
  const GenderField({required List<FocusNode> focusNodes, required FocusNode nextFocusNode, Key? key})
      : _focusNodes = focusNodes,
        _nextFocusNode = nextFocusNode,
        super(key: key);

  final List<FocusNode> _focusNodes;
  final FocusNode _nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonFormBloc, PersonFormState>(
      builder: (context, state) {
        return ToggleButtons(
          children: const [
            Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Text('Masculino')),
            Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Text('Feminino')),
          ],
          focusNodes: _focusNodes,
          isSelected: state.gender.value,
          color: Colors.black.withOpacity(0.60),
          selectedColor: Colors.blue,
          selectedBorderColor: Colors.blue,
          fillColor: Colors.blue.withOpacity(0.08),
          splashColor: Colors.blue.withOpacity(0.12),
          hoverColor: Colors.blue.withOpacity(0.04),
          borderRadius: BorderRadius.circular(4.0),
          constraints: const BoxConstraints(minHeight: 36.0),
          onPressed: (index) {
            context.read<PersonFormBloc>().add(GenderChanged(index));
            FocusScope.of(context).unfocus();
            if (state.address.invalid) {
              FocusScope.of(context).requestFocus(_nextFocusNode);
            }
          },
        );
      },
    );
  }
}
