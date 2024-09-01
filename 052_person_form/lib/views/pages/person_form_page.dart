import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:person_form/controllers/repositories/person_form_repository.dart';
import 'package:person_form/models/models/person.dart';
import 'package:person_form/models/repositories/person_form_repository.dart';
import 'package:person_form/models/services/api_service.dart';
import 'package:person_form/views/bloc/person_form_bloc.dart';
import 'package:person_form/views/widgets/address_field.dart';
import 'package:person_form/views/widgets/birthday_field.dart';
import 'package:person_form/views/widgets/form_button.dart';
import 'package:person_form/views/widgets/gender_field.dart';
import 'package:person_form/views/widgets/name_field.dart';
import 'package:person_form/views/widgets/picture_field.dart';

class PersonFormPage extends StatelessWidget {
  const PersonFormPage._(IPersonFormRepository repository, {required Person person, Key? key})
      : _repository = repository,
        _person = person,
        super(key: key);

  static const routeName = '/person_form';
  static Route route(Person? person, {required ApiService apiService}) {
    return MaterialPageRoute(builder: (context) {
      return PersonFormPage._(PersonFormRepository(apiService), person: person ?? Person.empty);
    });
  }

  final IPersonFormRepository _repository;
  final Person _person;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonFormBloc(_repository, _person),
      child: const PersonFormView(),
    );
  }
}

class PersonFormView extends StatefulWidget {
  const PersonFormView({Key? key}) : super(key: key);

  @override
  _PersonFormViewState createState() => _PersonFormViewState();
}

class _PersonFormViewState extends State<PersonFormView> {
  final _nameFocusNode = FocusNode();
  final _birthdayFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _genderFocusNodes = [FocusNode(), FocusNode()];
  final _submitFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        context.read<PersonFormBloc>().add(NameUnfocused());
      }
    });
    _birthdayFocusNode.addListener(() {
      if (!_birthdayFocusNode.hasFocus) {
        context.read<PersonFormBloc>().add(BirthdayUnfocused());
      }
    });
    _genderFocusNodes[0].addListener(() {
      if (!_genderFocusNodes[0].hasFocus) {
        context.read<PersonFormBloc>().add(GenderUnfocused());
      }
    });
    _genderFocusNodes[1].addListener(() {
      if (!_genderFocusNodes[1].hasFocus) {
        context.read<PersonFormBloc>().add(GenderUnfocused());
      }
    });
    _addressFocusNode.addListener(() {
      if (!_addressFocusNode.hasFocus) {
        context.read<PersonFormBloc>().add(AddressUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _birthdayFocusNode.dispose();
    _genderFocusNodes[0].dispose();
    _genderFocusNodes[1].dispose();
    _addressFocusNode.dispose();
    _submitFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _isToAddNewPerson = context.read<PersonFormBloc>().state.id.isEmpty;

    return Scaffold(
      appBar: AppBar(
        actions: _isToAddNewPerson
            ? null
            : [IconButton(icon: const Icon(Icons.delete), onPressed: () => context.read<PersonFormBloc>().add(DeleteRequested()))],
      ),
      body: BlocListener<PersonFormBloc, PersonFormState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 16),
                const PictureField(),
                const SizedBox(height: 32),
                NameField(focusNode: _nameFocusNode, nextFocusNode: _birthdayFocusNode),
                const SizedBox(height: 16),
                BirthdayField(focusNode: _birthdayFocusNode, nextFocusNode: _genderFocusNodes[0]),
                const SizedBox(height: 32),
                GenderField(focusNodes: _genderFocusNodes, nextFocusNode: _addressFocusNode),
                const SizedBox(height: 16),
                AddressField(focusNode: _addressFocusNode, nextFocusNode: _submitFocusNode),
                const SizedBox(height: 16),
                FormButton(focusNode: _submitFocusNode),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
