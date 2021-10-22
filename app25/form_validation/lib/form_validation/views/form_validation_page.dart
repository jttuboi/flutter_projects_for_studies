import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/form_validation/bloc/form_validation_bloc.dart';
import 'package:form_validation/form_validation/views/form_validation_view.dart';

class FormValidationPage extends StatelessWidget {
  const FormValidationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormValidationBloc>(
      create: (context) => FormValidationBloc(),
      child: const FormValidationView(),
    );
  }
}
