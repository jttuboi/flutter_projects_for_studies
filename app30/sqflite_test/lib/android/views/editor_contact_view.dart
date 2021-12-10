import 'package:flutter/material.dart';
import 'package:sqflite_test/android/views/home_view.dart';
import 'package:sqflite_test/models/contact_model.dart';
import 'package:sqflite_test/repositories/contact_repository.dart';

class EditorContactView extends StatefulWidget {
  const EditorContactView({Key? key, required this.model}) : super(key: key);

  final ContactModel model;

  @override
  _EditorContactViewState createState() => _EditorContactViewState();
}

class _EditorContactViewState extends State<EditorContactView> {
  final _formKey = GlobalKey<FormState>();
  final _repository = ContactRepository();

  onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    if (widget.model.id == 0) {
      create();
    } else {
      update();
    }
  }

  create() {
    widget.model.id = 0;
    widget.model.image = '';

    _repository.create(widget.model).then((_) {
      onSuccess();
    }).catchError((_) {
      onError();
    });
  }

  update() {
    _repository.update(widget.model).then((_) {
      onSuccess();
    }).catchError((_) {
      onError();
    });
  }

  onSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }

  onError() {
    const snackBar = SnackBar(content: Text('Ops, algo deu errado!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.model.id == 0 ? const Text("Novo Contato") : const Text("Editar Contato"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nome"),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                initialValue: widget.model.name,
                onChanged: (val) => widget.model.name = val,
                validator: (value) => (value!.isEmpty) ? 'Nome inválido' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Telefone"),
                keyboardType: TextInputType.number,
                initialValue: widget.model.phone,
                onChanged: (val) => widget.model.phone = val,
                validator: (value) => (value!.isEmpty) ? 'Telefone inválido' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                initialValue: widget.model.email,
                onChanged: (val) => widget.model.email = val,
                validator: (value) => (value!.isEmpty) ? 'E-mail inválido' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: IconButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: onSubmit,
                  icon: Icon(Icons.save, color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
