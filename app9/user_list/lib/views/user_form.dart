import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_list/models/user.dart';
import 'package:user_list/provider/users.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {"id": ""};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Object? user = ModalRoute.of(context)!.settings.arguments;
    if (user != null) {
      _loadFormData(user as User);
    }
  }

  _loadFormData(User user) {
    _formData["id"] = user.id;
    _formData["name"] = user.name;
    _formData["email"] = user.email;
    _formData["avatarUrl"] = user.avatarUrl;
  }

  String? _nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "name can't be empty";
    }
    if (value.trim().length < 3) {
      return "name is too small";
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "e-mail can't be empty";
    }
    return null;
  }

  String? _urlValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "url can't be empty";
    }
    return null;
  }

  _onSave() {
    bool isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      Provider.of<Users>(context, listen: false).put(User(
        id: _formData["id"]!,
        name: _formData["name"]!,
        email: _formData["email"]!,
        avatarUrl: _formData["avatarUrl"]!,
      ));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Form"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _onSave,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData["name"],
                keyboardType: TextInputType.name,
                validator: _nameValidator,
                onSaved: (value) => _formData["name"] = value!,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                initialValue: _formData["email"],
                keyboardType: TextInputType.emailAddress,
                validator: _emailValidator,
                onSaved: (value) => _formData["email"] = value!,
                decoration: InputDecoration(labelText: "E-mail"),
              ),
              TextFormField(
                initialValue: _formData["avatarUrl"],
                keyboardType: TextInputType.url,
                validator: _urlValidator,
                onSaved: (value) => _formData["avatarUrl"] = value!,
                decoration: InputDecoration(labelText: "Avatar URL"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
